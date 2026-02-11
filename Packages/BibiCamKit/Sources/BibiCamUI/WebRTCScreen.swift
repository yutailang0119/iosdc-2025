import Foundation
import SmartDeviceManagement
import SwiftUI
import Vision
@preconcurrency import WebRTC

struct WebRTCScreen: View {
  @State var state: ViewState

  var body: some View {
    Screen(state.phase) { connection in
      ZStack {
        VideoView(videoTrack: connection.videoTrack)
        GeometryReader { proxy in
          AnimalSkeletonView(animalBodyParts: state.parts, size: proxy.size)
        }
      }
      .onAppear {
        connection.videoTrack.add(state.detector)
      }
    }
    .task {
      await state.connect()
      await state.stream()
    }
    .onDisappear {
      Task {
        await state.close()
      }
    }
  }
}

extension WebRTCScreen {
  #if canImport(UIKit)
  struct VideoView: UIViewRepresentable {
    var videoTrack: RTCVideoTrack

    func makeUIView(context: Context) -> RTCMTLVideoView {
      let view = RTCMTLVideoView()
      view.videoContentMode = .scaleAspectFit
      return view
    }

    func updateUIView(_ uiView: RTCMTLVideoView, context: Context) {
      videoTrack.add(uiView)
    }
  }
  #elseif canImport(AppKit)
  struct VideoView: NSViewRepresentable {
    var videoTrack: RTCVideoTrack

    func makeNSView(context: Context) -> RTCMTLNSVideoView {
      let view = RTCMTLNSVideoView()
      return view
    }

    func updateNSView(_ nsView: RTCMTLNSVideoView, context: Context) {
      videoTrack.add(nsView)
    }
  }
  #endif
}

extension WebRTCScreen {
  @Observable
  final class ViewState {
    struct Connection {
      let mediaSessionID: String
      let peerConnection: RTCPeerConnection
      let videoTrack: RTCVideoTrack
      let scheduler: LiveStreamExtendScheduler
    }

    private let dependency: AppDependency
    private let isSkeletonEnabled: Bool

    private(set) var phase: ScreenPhase<Connection, Error> = .loading
    let detector = AnimalDetector()
    var parts: [VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint] = [:]

    init(
      dependency: AppDependency,
      isSkeletonEnabled: Bool,
    ) {
      self.dependency = dependency
      self.isSkeletonEnabled = isSkeletonEnabled
    }

    @MainActor
    func connect() async {
      guard let client = await dependency.smartDeviceManagement else {
        return
      }
      let factory = RTCPeerConnectionFactory()

      let configuration = RTCConfiguration()
      configuration.sdpSemantics = .unifiedPlan
      let constraints = RTCMediaConstraints(
        mandatoryConstraints: [
          kRTCMediaConstraintsOfferToReceiveAudio: kRTCMediaConstraintsValueTrue,
          kRTCMediaConstraintsOfferToReceiveVideo: kRTCMediaConstraintsValueTrue,
        ],
        optionalConstraints: nil
      )
      guard
        let peerConnection = factory.peerConnection(
          with: configuration,
          constraints: constraints,
          delegate: nil
        )
      else {
        phase = .empty
        return
      }
      let dataChannelConfiguration = RTCDataChannelConfiguration()
      dataChannelConfiguration.isOrdered = true
      _ = peerConnection.dataChannel(forLabel: "WebRTCData", configuration: dataChannelConfiguration)
      do {
        let offer = try await peerConnection.offer(for: constraints)
        try await peerConnection.setLocalDescription(offer)
        let request = CameraLiveStreamGenerateWebRTCRequest(
          projectID: dependency.projectID,
          deviceID: dependency.nestCamID,
          offerSdp: offer.sdp
        )
        let response = try await client.request(for: request)

        try await peerConnection.setRemoteDescription(
          RTCSessionDescription(type: .answer, sdp: response.results.answerSdp)
        )

        guard
          let videoTrack = peerConnection.transceivers
            .first(where: { $0.mediaType == .video })?
            .receiver.track as? RTCVideoTrack
        else {
          phase = .empty
          return
        }
        let scheduler = LiveStreamExtendScheduler(
          dependency: dependency,
          deviceID: dependency.nestCamID,
          mediaSessionID: response.results.mediaSessionID,
          expiresAt: response.results.expiresAt
        )
        phase = .loaded(
          Connection(
            mediaSessionID: response.results.mediaSessionID,
            peerConnection: peerConnection,
            videoTrack: videoTrack,
            scheduler: scheduler
          )
        )
      } catch {
        phase = .failed(error)
      }
    }

    @MainActor
    func stream() async {
      if isSkeletonEnabled {
        for await parts in detector.stream {
          self.parts = parts
        }
      }
    }

    @MainActor
    func close() async {
      guard case .loaded(let connection) = phase else {
        return
      }
      connection.peerConnection.close()
      let request = CameraLiveStreamStopWebRTCRequest(
        projectID: dependency.projectID,
        deviceID: dependency.nestCamID,
        mediaSessionID: connection.mediaSessionID
      )
      _ = try? await dependency.smartDeviceManagement?.request(for: request)
      self.phase = .empty
    }
  }
}

extension WebRTCScreen.ViewState {
  @MainActor
  final class LiveStreamExtendScheduler {
    private let worker: ScheduleWorker

    init(
      dependency: AppDependency,
      deviceID: String,
      mediaSessionID: String,
      expiresAt: Date?,
    ) {
      worker = ScheduleWorker(
        date: expiresAt?.addingTimeInterval(-60)
      ) {
        guard let client = await dependency.smartDeviceManagement else {
          return nil
        }
        let request = CameraLiveStreamExtendWebRTCRequest(
          projectID: dependency.projectID,
          deviceID: deviceID,
          mediaSessionID: mediaSessionID
        )
        let response = try await client.request(for: request)
        return response.results.expiresAt?.addingTimeInterval(-60)
      }
    }

    func cancel() async {
      await worker.cancel()
    }
  }
}

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
      let mediaSessionId: String
      let peerConnection: RTCPeerConnection
      let videoTrack: RTCVideoTrack
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
          projectId: dependency.projectId,
          deviceId: dependency.nestCamId,
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
        phase = .loaded(
          Connection(
            mediaSessionId: response.results.mediaSessionId,
            peerConnection: peerConnection,
            videoTrack: videoTrack
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
        projectId: dependency.projectId,
        deviceId: dependency.nestCamId,
        mediaSessionId: connection.mediaSessionId
      )
      _ = try? await dependency.smartDeviceManagement?.request(for: request)
      self.phase = .empty
    }
  }
}

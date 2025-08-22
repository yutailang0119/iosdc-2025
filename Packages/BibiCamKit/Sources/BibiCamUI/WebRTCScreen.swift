import Foundation
import SmartDeviceManagement
import SwiftUI
@preconcurrency import WebRTC

struct WebRTCScreen: View {
  @State var state: ViewState

  var body: some View {
    Screen(state.phase) {
      VideoView(videoTrack: $0.videoTrack)
        .toolbar {
          ToolbarItem {
            Button {
              Task {
                await state.close()
              }
            } label: {
              Label("Disconnect", symbol: .stop)
            }
          }
        }
    } empty: {
      ContentUnavailableView {
        Label("No video stream", symbol: .webCamera)
      } actions: {
        Button {
          Task {
            await state.connect()
          }
        } label: {
          Label("Connect", symbol: .play)
        }
      }
    }
    .task {
      await state.connect()
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
    let videoTrack: RTCVideoTrack

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
    let videoTrack: RTCVideoTrack

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
    private let deviceId: String

    private(set) var phase: ScreenPhase<Connection, Error> = .loading

    init(dependency: AppDependency, deviceId: String) {
      self.dependency = dependency
      self.deviceId = deviceId
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
          deviceId: deviceId,
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
    func close() async {
      guard case .loaded(let connection) = phase else {
        return
      }
      connection.peerConnection.close()
      let request = CameraLiveStreamStopWebRTCRequest(
        deviceId: deviceId,
        mediaSessionId: connection.mediaSessionId
      )
      _ = try? await dependency.smartDeviceManagement?.request(for: request)
      self.phase = .empty
    }
  }
}

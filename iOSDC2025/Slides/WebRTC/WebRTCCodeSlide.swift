//
//  WebRTCCodeSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct WebRTCCodeSlide: View {
  enum SlidePhasedState: Int, PhasedState {
    case initial, second, third
  }

  @Phase var phase: SlidePhasedState

  var body: some View {
    Group {
      switch phase {
      case .initial:
        CodeSlide(
          code: """
            // 1. RTCPeerConnectionを作成 with RTCDataChannel
            let factory = RTCPeerConnectionFactory()

            let configuration = RTCConfiguration()
            let constraints = RTCMediaConstraints(
              mandatoryConstraints: [
                kRTCMediaConstraintsOfferToReceiveAudio: kRTCMediaConstraintsValueTrue,
                kRTCMediaConstraintsOfferToReceiveVideo: kRTCMediaConstraintsValueTrue,
              ],
              optionalConstraints: nil
            )
            let peerConnection = factory.peerConnection(
              with: configuration,
              constraints: constraints,
              delegate: nil
            )!

            let dataChannelConfiguration = RTCDataChannelConfiguration()
            dataChannelConfiguration.isOrdered = true
            _ = peerConnection.dataChannel(
              forLabel: "WebRTCData",
              configuration: dataChannelConfiguration
            )
            """
        )
      case .second:
        CodeSlide(
          code: """
            // 2. SDP Offerを生成
            let offer = try! await peerConnection.offer(for: constraints)
            try await peerConnection.setLocalDescription(offer)

            // 3. SDM APIにSDP Offerを送信
            // 4. SDP Answerを受信
            let request = CameraLiveStreamGenerateWebRTCRequest(
              projectId: dependency.projectId,
              deviceId: dependency.nestCamId,
              offerSdp: offer.sdp
            )
            let response = try await client.request(for: request)

            // 5. RTCPeerConnectionにSDP Answerを適用
            try await peerConnection.setRemoteDescription(
              RTCSessionDescription(type: .answer, sdp: response.results.answerSdp)
            )
            """
        )
      case .third:
        CodeSlide(
          code: """
            // RTCVideoTrackを取得
            let videoTrack = peerConnection.transceivers
              .first(where: { $0.mediaType == .video })?
              .receiver.track as? RTCVideoTrack

            // RTCMTLNSVideoViewで再生
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
            """
        )
      }
    }
    .background(.background)
  }

  var script: String {
    switch phase {
    case .initial:
      """
      実装で見ていきましょう
      FactoryでPeerConnectionを作成
      DataChannelの追加を忘れずに
      """
    case .second:
      """
      PeerConnectionから生成したOfferを使ってSDM APIをリクエスト
      APIレスポンスのAnswerをPeerConnectionに適用
      これでWebRTCのコネクション準備が整いました
      """
    case .third:
      """
      映像の再生は VideoTrack を取り出して、
      Metalレンダリングの VideoView を接続すると再生が始まります
      """
    }
  }
}

#Preview {
  SlidePreview {
    WebRTCCodeSlide()
  }
}

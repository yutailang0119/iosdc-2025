//
//  WebRTCStepsSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct WebRTCStepsSlide: View {
  enum SlidePhasedState: Int, PhasedState {
    case initial, second
  }

  @Phase var phase: SlidePhasedState

  var body: some View {
    Group {
      switch phase {
      case .initial:
        HeaderSlide("WebRTC") {
          Item("RTCPeerConnectionを作成", accessory: .number(1)) {
            Item("with RTCDataChannel")
          }
          Item("SDP Offerを生成", accessory: .number(2))
          Item("Smart Device Management APIにSDP Offerを送信", accessory: .number(3)) {
            Item("sdm.devices.commands.CameraLiveStream.GenerateWebRtcStream")
          }
          Item("SDP Answerを受信", accessory: .number(4))
          Item("RTCPeerConnectionにSDP Answerを適用", accessory: .number(5))
          Item("映像再生", accessory: .number(6))
        }
      case .second:
        ImageSlide(image: Image(.webRTCConnectionSteps))
      }
    }
    .background(.background)
  }

  var script: String {
    switch phase {
    case .initial:
      """
      以下の手順でコネクションを確立していきます
      """
    case .second:
      """
      図にするとこんな感じ
      """
    }
  }
}

#Preview {
  SlidePreview {
    WebRTCStepsSlide()
  }
}

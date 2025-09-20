//
//  ConclusionSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/12.
//

import SlideKit
import SwiftUI

@Slide
struct ConclusionSlide: View {
  var body: some View {
    HeaderSlide("まとめ") {
      Item("Google Nest Camへアクセス") {
        Item("Google Cloud OAuth 2.0 (Google Sign-In)")
        Item("Smart Device Management API")
        Item("WebRTC")
      }
      Item("WebRTC -> Core Video -> Vision.framework")
      Item("猫のポーズ検出") {
        Item("VNDetectAnimalBodyPoseRequest")
      }
      Item("どんな時でも猫はかわいい")
    }
    .background(.background)
  }

  var script: String {
    """
    Google Nest CamにAPIでアクセス
    WebRTCからCore Video、Vision.frameworkと接続し
    猫のポーズ検出を紹介しました
    """
  }
}

#Preview {
  SlidePreview {
    ConclusionSlide()
  }
}

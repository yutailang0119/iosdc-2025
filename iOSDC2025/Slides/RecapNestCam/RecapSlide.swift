//
//  RecapNestCamSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct RecapNestCamSlide: View {
  var body: some View {
    HeaderSlide("Recap: Google Nest Cam") {
      Item("WebRTCで映像接続") {
        Item("Google Cloud OAuth 2.0を用意 (Google Sign-In)")
        Item("Smart Device Management APIを実行")
        Item("WebRTCでGoogle Nest Camと接続")
      }
      Item("Google Nest Cam -> Appleプラットフォーム") {
        Item("映像再生に留まらず、機能拡張が可能")
      }
    }
    .background(.background)
  }

  var script: String {
    """
    Google Nest CamにWebRTCで接続し、映像を再生できました
    Google Nest CamからAppleプラットフォームにやってきたことで、私たちの領域で機能拡張可能になりました
    """
  }
}

#Preview {
  SlidePreview {
    RecapNestCamSlide()
  }
}

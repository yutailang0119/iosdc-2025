//
//  NestCamConnectTitleSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct NestCamConnectTitleSlide: View {
  var body: some View {
    TitleSlide(
      text: """
        Google Nest Camに
        WebRTCで映像接続
        """
    )
    .background(.background)
  }

  var script: String {
    """
    さっそく、Google Nest CamにWebRTCで接続し、映像を再生します
    """
  }
}

#Preview {
  SlidePreview {
    NestCamConnectTitleSlide()
  }
}

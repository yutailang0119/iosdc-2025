//
//  NestCamSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/28.
//

import SlideKit
import SwiftUI

@Slide
struct NestCamSlide: View {
  var body: some View {
    SplitSlide {
      HeaderSlide("Google Nest Cam") {
        Item("Google Homeに連携") {
          Item("アプリ、Web")
        }
        Item("Google Nest Aware") {
          Item("サブスクリプションプラン")
        }
        Item("APIが提供されている") {
          Item(
            """
            Smart Device Management API
            (SDM API)
            """
          )
          Item("WebRTC Support")
        }
      }
    } detail: {
      CenteringSlide {
        Image(.nestCam)
          .resizable()
          .scaledToFit()
          .frame(width: 720, height: 720)
      }
    }
    .background(.background)
  }

  var script: String {
    """
    Google Nest Camの魅力は、Google Homeと連携した使い方はもちろん
    Smart Device Management APIが提供され、WebRTCによる映像通信をサポートしていることです
    """
  }
}

#Preview {
  SlidePreview {
    NestCamSlide()
  }
}

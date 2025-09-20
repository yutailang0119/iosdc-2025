//
//  NestCamStepsSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/28.
//

import SlideKit
import SwiftUI

@Slide
struct NestCamStepsSlide: View {
  var body: some View {
    HeaderSlide("Google Nest Camへの接続手順") {
      Item("Google Cloud OAuth 2.0 (Google Sign-In)", accessory: .number(1))
      Item("Smart Device Management API", accessory: .number(2))
      Item("WebRTC", accessory: .number(3))
    }
    .background(.background)
  }

  var script: String {
    """
    手順はおおまかに3ステップ
    """
  }
}

#Preview {
  SlidePreview {
    NestCamStepsSlide()
  }
}

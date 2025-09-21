//
//  VisionFrameworkSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct VisionFrameworkSlide: View {
  var body: some View {
    HeaderSlide("Vision framework") {
      Item("⚠️ シミュレーターでは使用できない")
      Item("> * Tracking human and animal body poses or the trajectory of an object")
      Item("VNImageRequestHandlerを通して、画像の処理を実行")
    }
    .background(.background)
  }

  var script: String {
    """
    前提として、Vision frameworkはシミュレーターでは使用できません
    Vision frameworkの概要には「人間と動物のポーズや軌跡を追跡する」と記載されています
    ここでは画像に関する処理なので、`VNImageRequestHandler` を使用します
    """
  }
}

#Preview {
  SlidePreview {
    VisionFrameworkSlide()
  }
}

//
//  VisionFrameworkTitleSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct VisionFrameworkTitleSlide: View {
  var body: some View {
    TitleSlide(
      text: """
        猫のポーズを可視化
        with
        Vision framework
        """
    )
    .background(.background)
  }

  var script: String {
    """
    ここからは映像をVision frameworkと連携していきます
    """
  }
}

#Preview {
  SlidePreview {
    VisionFrameworkTitleSlide()
  }
}

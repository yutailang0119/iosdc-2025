//
//  BonyarTitleSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/19.
//

import SlideKit
import SwiftUI

@Slide
struct BonyarTitleSlide: View {
  var body: some View {
    TitleSlide(
      text: """
        猫のかわいいポーズとは？
        """
    )
    .background(.background)
  }

  var script: String {
    """
    ポーズの検出はできました
    では、猫のかわいいポーズとは？
    """
  }
}

#Preview {
  SlidePreview {
    BonyarTitleSlide()
  }
}

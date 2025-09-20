//
//  IntroductionTitleSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct IntroductionTitleSlide: View {
  var body: some View {
    TitleSlide(text: "ある日、猫がやってきた")
      .background(.background)
  }

  var script: String {
    """
    ビビとの暮らしは
    """
  }
}

#Preview {
  SlidePreview {
    IntroductionTitleSlide()
  }
}

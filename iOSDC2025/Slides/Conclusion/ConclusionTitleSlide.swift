//
//  ConclusionTitleSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/12.
//

import SlideKit
import SwiftUI

@Slide
struct ConclusionTitleSlide: View {
  var body: some View {
    TitleSlide(text: "まとめ")
      .background(.background)
  }

  var script: String {
    """
    まとめ
    """
  }
}

#Preview {
  SlidePreview {
    ConclusionTitleSlide()
  }
}

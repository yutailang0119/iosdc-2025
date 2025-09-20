//
//  RecapNestCamTitleSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/12.
//

import SlideKit
import SwiftUI

@Slide
struct RecapNestCamTitleSlide: View {
  var body: some View {
    TitleSlide(
      text: """
        Recap:
        Google Nest Cam
        """
    )
    .background(.background)
  }

  var script: String {
    """
    ここまでのまとめ
    """
  }
}

#Preview {
  SlidePreview {
    RecapNestCamTitleSlide()
  }
}

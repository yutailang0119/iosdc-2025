//
//  DetectAnimalBodyPoseTitleSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/12.
//

import SlideKit
import SwiftUI

@Slide
struct DetectAnimalBodyPoseTitleSlide: View {
  var body: some View {
    TitleSlide(
      text: """
        映像解析
        """
    )
    .background(.background)
  }

  var script: String {
    """
    画像で試したので、次は映像として解析します
    """
  }
}

#Preview {
  SlidePreview {
    DetectAnimalBodyPoseTitleSlide()
  }
}

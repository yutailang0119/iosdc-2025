//
//  BonyarRecapSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/19.
//

import SlideKit
import SwiftUI

@Slide
struct BonyarRecapSlide: View {
  var body: some View {
    TitleSlide(
      text: """
        ポーズの詳細な分析には
        性能向上が待たれる
        """
    )
    .background(.background)
  }

  var script: String {
    """
    ジョイント追跡数が増えることに期待しましょう
    """
  }
}

#Preview {
  SlidePreview {
    BonyarRecapSlide()
  }
}

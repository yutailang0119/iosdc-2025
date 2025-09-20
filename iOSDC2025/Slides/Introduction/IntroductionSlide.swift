//
//  IntroductionSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct IntroductionSlide: View {
  var body: some View {
    HeaderSlide("猫がやって来た") {
      Item("引っ越しを機に、ビビとの暮らしがスタート") {
        Item("動物との生活が初めて")
      }
      Item("外出中も様子が気になる")
      Item("ネットワークカメラ (ペットカメラ) を導入") {
        Item("Google Nest Cam")
      }
    }
    .background(.background)
  }

  var script: String {
    """
    引っ越しに合わせて始まりました
    猫どころか、動物との生活が初めての経験
    外出先でも様子を見るため、ネットワークカメラ、いわゆるペットカメラとしてGoogle Nest Camを購入しました
    """
  }
}

#Preview {
  SlidePreview {
    IntroductionSlide()
  }
}

//
//  DetectAnimalBodyPoseDemoSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/10.
//

import BibiCamKit
import SlideKit
import SwiftUI

@Slide
struct DetectAnimalBodyPoseDemoSlide: View {
  enum SlidePhasedState: Int, PhasedState {
    case initial, second, third
  }

  @Phase var phase: SlidePhasedState

  var body: some View {
    Group {
      switch phase {
      case .initial:
        TitleSlide(text: "Demo")
      case .second:
        NestCamScreen(isSkeletonEnabled: true)
      case .third:
        VideoSlide(
          url: Bundle.main.url(forResource: "Demo2", withExtension: "mov")!
        )
      }
    }
    .background(.background)
  }

  var script: String {
    switch phase {
    case .initial:
      """
      先ほど同様
      """
    case .second:
      """
      Google Nest CamのWebRTC映像に接続し、ポーズ解析を重ねて表示しています
      """
    case .third:
      """
      こちらも事前に撮影した映像をご覧ください
      猫の動きに合わせて、トラッキングできていそうです
      """
    }
  }

  var shouldHideIndex: Bool {
    switch phase {
    case .initial: false
    case .second, .third: true
    }
  }
}

#Preview {
  SlidePreview {
    DetectAnimalBodyPoseDemoSlide()
  }
}

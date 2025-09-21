//
//  WebRTCDemoSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/28.
//

import AVKit
import BibiCamKit
import SlideKit
import SwiftUI

@Slide
struct WebRTCDemoSlide: View {
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
        NestCamScreen(isSkeletonEnabled: false)
      case .third:
        VideoSlide(
          url: Bundle.main.url(forResource: "Demo1", withExtension: "mov")!
        )
      }
    }
    .background(.background)
  }

  var script: String {
    switch phase {
    case .initial:
      """
      ということで、
      """
    case .second:
      """
      現在の自宅の映像をお送りしています
      猫様は人間の思い通りにならないので、
      """
    case .third:
      """
      事前に撮影した映像をご覧ください
      うちのビビ、かわいいですね
      この動画は編集していますが、AudioChannelを有効にしているので、音声も聞こえます
      仕組み的には、こちら側の音声を送ることも可能なはず
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
    WebRTCDemoSlide()
  }
}

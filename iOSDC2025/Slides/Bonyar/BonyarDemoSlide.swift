//
//  BonyarDemoSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/19.
//

import SlideKit
import SwiftUI

@Slide
struct BonyarDemoSlide: View {
  enum SlidePhasedState: Int, PhasedState {
    case initial, second

    var isSkeletonEnabled: Bool {
      switch self {
      case .initial: false
      case .second: true
      }
    }
  }

  @Phase var phase: SlidePhasedState

  var body: some View {
    CenteringSlide {
      PoseImage(
        image: NSImage(resource: .bibiBonyar),
        isSkeletonEnabled: phase.isSkeletonEnabled,
      )
    }
    .background(.background)
  }

  var script: String {
    switch self.phase {
    case .initial:
      """
      暗闇で光る目がかわいいですね
      不在の間に偶然撮影されたボニャール画像を、ポーズ検出で特定できるかというと
      """
    case .second:
      """
      胴体のジョイントが少ないため、背中の山なりは特定が困難です
      """
    }
  }
}

#Preview {
  SlidePreview {
    BonyarDemoSlide()
  }
}

//
//  VNImageBasedRequestDemoSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct VNImageBasedRequestDemoSlide: View {
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
        image: NSImage(resource: .bibiBodyPose),
        isSkeletonEnabled: phase.isSkeletonEnabled,
      )
    }
    .background(.background)
  }

  var script: String {
    switch self.phase {
    case .initial:
      """
      この画像でジョイント同士を繋ぐと
      """
    case .second:
      """
      こう
      ちなみに、スライドはSlideKitを使ってmacOSアプリとして実行しているので、画像処理はこの場で行なっています
      """
    }
  }
}

#Preview {
  SlidePreview {
    VNImageBasedRequestDemoSlide()
  }
}

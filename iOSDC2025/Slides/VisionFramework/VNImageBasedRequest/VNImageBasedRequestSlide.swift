//
//  VNImageBasedRequestSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct VNImageBasedRequestSlide: View {
  enum SlidePhasedState: Int, PhasedState {
    case initial, second

    var foregroundStyle: HierarchicalShapeStyle {
      switch self {
      case .initial: .primary
      case .second: .tertiary
      }
    }
  }

  @Phase var phase: SlidePhasedState

  var body: some View {
    HeaderSlide("画像解析: VNImageBasedRequest") {
      Item("Animal") {
        Item("VNRecognizeAnimalsRequest") {
          Item("> A request that recognizes animals in an image.")
        }
        .foregroundStyle(phase.foregroundStyle)
        Item("VNDetectAnimalBodyPoseRequest") {
          Item("> A request that detects an animal body pose.")
        }
      }
      Item("Human") {
        Item("VNDetectHumanBodyPoseRequest")
        Item("VNDetectHumanHandPoseRequest")
        Item("...")
      }
      .foregroundStyle(phase.foregroundStyle)
    }
    .background(.background)
  }

  var script: String {
    switch phase {
    case .initial:
      """
      人間や動物に対するリクエストは、いくつかあります
      """
    case .second:

      """
      今回は `VNDetectAnimalBodyPoseRequest` を利用して、猫のポーズを検出します
      """
    }
  }
}

#Preview {
  SlidePreview {
    VNImageBasedRequestSlide()
  }
}

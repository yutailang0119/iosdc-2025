//
//  DetectAnimalBodyPoseStepsSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/10.
//

import SlideKit
import SwiftUI

@Slide
struct DetectAnimalBodyPoseStepsSlide: View {
  var body: some View {
    HeaderSlide("WebRTC -> Core Video -> Vision.framework") {
      Item("WebRTC.RTCVideoRendererで処理開始", accessory: .number(1))
      Item("CoreVideo.CVPixelBufferに変換", accessory: .number(2))
      Item("VNImageRequestHandler.perform(_:options:)", accessory: .number(3)) {
        Item("with VNImageRequestHandler")
      }
      Item("VNHumanBodyObservation.recognizedPoints(_:)", accessory: .number(4))
      Item("VNRecognizedPointを動画にプロット", accessory: .number(5))
    }
    .background(.background)
  }

  var script: String {
    """
    準備が整いました
    WebRTCからCore Video、Vision.frameworkと繋いで、解析したジョイントを動画に重ねてプロットします
    """
  }
}

#Preview {
  SlidePreview {
    DetectAnimalBodyPoseStepsSlide()
  }
}

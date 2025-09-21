//
//  CVPixelBufferSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct CVPixelBufferSlide: View {
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
    HeaderSlide {
      Text("WebRTC -> Core Video")
        + Text(" -> Vision framework").foregroundStyle(.tertiary)
    } content: {
      Item("VNImageRequestHandler.init") {
        Item("CoreGraphics.CGImage")
        Item("CoreImage.CIImage")
        Item("CoreVideo.CVPixelBuffer")
          .foregroundStyle(.primary)
        Item("CoreMedia.CMSampleBuffer")
        Item("Foundation.Data/URL")
      }
      .foregroundStyle(phase.foregroundStyle)
      if phase == .second {
        Item("WebRTC.RTCVideoFrame -> CoreVideo.CVPixelBuffer") {
          Item("RTCVideoFrame.buffer as? RTCCVPixelBuffer")
          Item("RTCCVPixelBuffer.pixelBuffer: CVPixelBuffer")
        }
      }
    }
    .background(.background)
  }

  var script: String {
    switch phase {
    case .initial:
      """
      前述の `VNImageRequestHandler` はいくつかのインプットをサポートしています
      """
    case .second:
      """
      今回はCore Videoの `CVPixelBuffer` を使うことにします
      WebRTCからCore Videoへの変換は `RTCCVPixelBuffer` 経由で行えそうです
      """
    }
  }
}

#Preview {
  SlidePreview {
    CVPixelBufferSlide()
  }
}

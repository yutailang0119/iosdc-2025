//
//  DetectAnimalBodyPoseCodeSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct DetectAnimalBodyPoseCodeSlide: View {
  var body: some View {
    CodeSlide(
      code: """
        final class AnimalDetector: NSObject, RTCVideoRenderer {
          func setSize(_ size: CGSize) {}

          func renderFrame(_ frame: RTCVideoFrame?) {
            guard let buffer = frame?.buffer as? RTCCVPixelBuffer else {
                return
            }

            let request = VNDetectAnimalBodyPoseRequest()
            let handler = VNImageRequestHandler(
              cvPixelBuffer: buffer.pixelBuffer,
              options: [:]
            )
            try? handler.perform([request])
            guard let parts = try? request.results?.first?.recognizedPoints(.all) else {
              return
            }
            // Plot parts
          }
        }
        """
    )
    .background(.background)
  }

  var script: String {
    """
    実装ではこのようにジョイントが取得できます
    """
  }
}

#Preview {
  SlidePreview {
    DetectAnimalBodyPoseCodeSlide()
  }
}

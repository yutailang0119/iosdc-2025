//
//  VNAnimalBodyPoseObservationJointNameSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct VNAnimalBodyPoseObservationJointNameSlide: View {
  var body: some View {
    HeaderSlide("VNAnimalBodyPoseObservation.JointName") {
      HStack(alignment: .top) {
        VStack(alignment: .leading) {
          Item("head (9)") {
            Item("leftEye, rightEye, nose")
            Item("leftEarTop, leftEarMiddle, leftEarBottom")
            Item("rightEarTop, rightEarMiddle, rightEarBottom")
          }
          Item("trunk (1)") {
            Item("neck")
          }
          Item("tail (3)") {
            Item("tailTop, tailMiddle, tailBottom")
          }
        }
        //        .frame(maxWidth: .infinity)
        VStack(alignment: .leading) {
          Item("forelegs (6)") {
            Item("leftFrontPaw, leftFrontElbow, leftFrontKnee")
            Item("rightFrontPaw, rightFrontElbow, rightFrontKnee")
          }
          Item("hindlegs (6)") {
            Item("leftBackPaw, leftBackElbow, leftBackKnee")
            Item("rightBackPaw, rightBackElbow, rightBackKnee")
          }
        }
        //        .frame(maxWidth: .infinity)
      }
    }
    .background(.background)
  }

  var script: String {
    """
    (2026年OS) 現在、25箇所のジョイントが定義されています
    """
  }
}

#Preview {
  SlidePreview {
    VNAnimalBodyPoseObservationJointNameSlide()
  }
}

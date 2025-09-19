import BibiCamUI
import SwiftUI
@preconcurrency import Vision

public struct SkeletonPoseScreen: View {
  var parts: [VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint]
  var size: CGSize

  public init(
    parts: [VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint],
    size: CGSize,
  ) {
    self.parts = parts
    self.size = size
  }

  public var body: some View {
    AnimalSkeletonView(
      animalBodyParts: parts,
      size: size,
      color: .accentColor,
      isDotsEnabled: true,
    )
  }
}

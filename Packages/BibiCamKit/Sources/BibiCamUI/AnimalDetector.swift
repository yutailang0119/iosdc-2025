import CoreVideo
@preconcurrency import Vision
import WebRTC

final class AnimalDetector: NSObject, RTCVideoRenderer {
  let stream: AsyncStream<[VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint]>
  private let continuation: AsyncStream<[VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint]>.Continuation

  override init() {
    (self.stream, self.continuation) = AsyncStream<[VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint]>
      .makeStream()
  }

  func setSize(_ size: CGSize) {}

  func renderFrame(_ frame: RTCVideoFrame?) {
    guard let buffer = frame?.buffer as? RTCCVPixelBuffer else {
      return
    }

    let request = VNDetectAnimalBodyPoseRequest { result, error in
      guard let results = result.results as? [VNAnimalBodyPoseObservation],
        let parts = try? results.first?.recognizedPoints(.all)
      else {
        return
      }
      self.continuation.yield(parts)
    }

    let handler = VNImageRequestHandler(cvPixelBuffer: buffer.pixelBuffer, options: [:])
    try? handler.perform([request])
  }
}

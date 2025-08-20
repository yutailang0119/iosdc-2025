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
    guard let frame = frame,
      let buffer = frame.buffer.toI420().toCVPixelBuffer()
    else {
      return
    }

    let request = VNDetectAnimalBodyPoseRequest()
    let handler = VNImageRequestHandler(cvPixelBuffer: buffer, options: [:])
    try? handler.perform([request])
    guard let animalBodyAllParts = try? request.results?.first?.recognizedPoints(.all) else {
      return
    }
    continuation.yield(animalBodyAllParts)
  }
}

private extension RTCI420BufferProtocol {
  func toCVPixelBuffer() -> CVPixelBuffer? {
    let width = Int(width)
    let height = Int(height)

    var addresses: [UnsafeMutableRawPointer?] = [
      UnsafeMutableRawPointer(mutating: dataY),
      UnsafeMutableRawPointer(mutating: dataU),
      UnsafeMutableRawPointer(mutating: dataV),
    ]
    var widths = [width, width / 2, width / 2]
    var heights = [height, height / 2, height / 2]
    var strides = [
      Int(strideY),
      Int(strideU),
      Int(strideV),
    ]

    var pixelBuffer: CVPixelBuffer?
    let result = addresses.withUnsafeMutableBufferPointer { plane in
      widths.withUnsafeMutableBufferPointer { planeWidth in
        heights.withUnsafeMutableBufferPointer { planeHeight in
          strides.withUnsafeMutableBufferPointer { planeBytesPerRow in
            CVPixelBufferCreateWithPlanarBytes(
              kCFAllocatorDefault,
              width,
              height,
              kCVPixelFormatType_420YpCbCr8Planar,
              nil,
              0,
              3,
              plane.baseAddress!,
              planeWidth.baseAddress!,
              planeHeight.baseAddress!,
              planeBytesPerRow.baseAddress!,
              nil,
              nil,
              nil,
              &pixelBuffer
            )
          }
        }
      }
    }

    return (result == kCVReturnSuccess) ? pixelBuffer : nil
  }
}

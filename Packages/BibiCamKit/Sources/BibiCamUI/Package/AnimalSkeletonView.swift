import SwiftUI
import Vision

package struct AnimalSkeletonView: View {
  var animalBodyParts: [[VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint]]
  var size: CGSize
  var color: Color?
  var isDotsEnabled: Bool

  package init(
    animalBodyParts: [[VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint]],
    size: CGSize,
    color: Color? = nil,
    isDotsEnabled: Bool = false
  ) {
    self.animalBodyParts = animalBodyParts
    self.size = size
    self.color = color
    self.isDotsEnabled = isDotsEnabled
  }

  package var body: some View {
    ZStack {
      ForEach(animalBodyParts, id: \.self) {
        SkeletonView(
          parts: $0,
          size: size,
          color: color,
          isDotsEnabled: isDotsEnabled
        )
      }
    }
  }
}

private extension AnimalSkeletonView {
  struct SkeletonView: View {
    var parts: [VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint]
    var size: CGSize
    var color: Color?
    var isDotsEnabled: Bool

    var body: some View {
      if !parts.isEmpty {
        ZStack {
          ZStack {
            // left head
            if let nose = parts[.nose] {
              if let leftEye = parts[.leftEye] {
                Line(points: [nose.location, leftEye.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.orange)
              }
            }
            if let leftEye = parts[.leftEye] {
              if let leftEarBottom = parts[.leftEarBottom] {
                Line(points: [leftEye.location, leftEarBottom.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.orange)
              }
            }
            if let leftEarBottom = parts[.leftEarBottom] {
              if let leftEarMiddle = parts[.leftEarMiddle] {
                if let leftEarTop = parts[.leftEarTop] {
                  Line(
                    points: [
                      leftEarBottom.location, leftEarMiddle.location,
                      leftEarTop.location,
                    ],
                    size: size
                  )
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.orange)
                }
              }
            }
            // right head
            if let nose = parts[.nose] {
              if let rightEye = parts[.rightEye] {
                Line(points: [nose.location, rightEye.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.orange)
              }
            }
            if let rightEye = parts[.rightEye] {
              if let rightEarBottom = parts[.rightEarBottom] {
                Line(points: [rightEye.location, rightEarBottom.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.orange)
              }
            }
            if let rightEarBottom = parts[.rightEarBottom] {
              if let rightEarMiddle = parts[.rightEarMiddle] {
                if let rightEarTop = parts[.rightEarTop] {
                  Line(
                    points: [
                      rightEarBottom.location, rightEarMiddle.location,
                      rightEarTop.location,
                    ],
                    size: size
                  )
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.orange)
                }
              }
            }
            // trunk - The nose to the neck.
            if let nose = parts[.nose] {
              if let neck = parts[.neck] {
                Line(points: [nose.location, neck.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.yellow)
              }
            }
            // tail - The neck to the bottom tail.
            if let neck = parts[.neck] {
              if let tailBottom = parts[.tailBottom] {
                Line(
                  points: [
                    neck.location,
                    tailBottom.location,
                  ],
                  size: size
                )
                .stroke(lineWidth: 5.0)
                .fill(color ?? Color.green)
              }
            }
          }
          ZStack {
            // left forelegs
            if let neck = parts[.neck] {
              if let leftFrontElbow = parts[.leftFrontElbow] {
                Line(points: [neck.location, leftFrontElbow.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.purple)
              }
            }
            if let leftFrontElbow = parts[.leftFrontElbow] {
              if let leftFrontKnee = parts[.leftFrontKnee] {
                if let leftFrontPaw = parts[.leftFrontPaw] {
                  Line(points: [leftFrontElbow.location, leftFrontKnee.location, leftFrontPaw.location], size: size)
                    .stroke(lineWidth: 5.0)
                    .fill(color ?? Color.purple)
                }
              }
            }
            // right forelegs
            if let neck = parts[.neck] {
              if let rightFrontElbow = parts[.rightFrontElbow] {
                Line(points: [neck.location, rightFrontElbow.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.purple)
              }
            }
            if let rightFrontElbow = parts[.rightFrontElbow] {
              if let rightFrontKnee = parts[.rightFrontKnee] {
                if let rightFrontPaw = parts[.rightFrontPaw] {
                  Line(points: [rightFrontElbow.location, rightFrontKnee.location, rightFrontPaw.location], size: size)
                    .stroke(lineWidth: 5.0)
                    .fill(color ?? Color.purple)
                }
              }
            }
            // left hindlegs
            if let tailBottom = parts[.tailBottom] {
              if let leftBackElbow = parts[.leftBackElbow] {
                Line(points: [tailBottom.location, leftBackElbow.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.blue)
              }
            }
            if let leftBackElbow = parts[.leftBackElbow] {
              if let leftBackKnee = parts[.leftBackKnee] {
                if let leftBackPaw = parts[.leftBackPaw] {
                  Line(points: [leftBackElbow.location, leftBackKnee.location, leftBackPaw.location], size: size)
                    .stroke(lineWidth: 5.0)
                    .fill(color ?? Color.blue)
                }
              }
            }
            // right hindlegs
            if let tailBottom = parts[.tailBottom] {
              if let rightBackElbow = parts[.rightBackElbow] {
                Line(points: [tailBottom.location, rightBackElbow.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.blue)
              }
            }
            if let rightBackElbow = parts[.rightBackElbow] {
              if let rightBackKnee = parts[.rightBackKnee] {
                if let rightBackPaw = parts[.rightBackPaw] {
                  Line(points: [rightBackElbow.location, rightBackKnee.location, rightBackPaw.location], size: size)
                    .stroke(lineWidth: 5.0)
                    .fill(color ?? Color.blue)
                }
              }
            }
          }
          ZStack {
            // tails.
            if let tailBottom = parts[.tailBottom] {
              if let tailMiddle = parts[.tailMiddle] {
                if let tailTop = parts[.tailTop] {
                  Line(points: [tailBottom.location, tailMiddle.location, tailTop.location], size: size)
                    .stroke(lineWidth: 5.0)
                    .fill(color ?? Color.orange)
                }
              }
            }
          }
        }
        if isDotsEnabled {
          ForEach(parts.map(\.value.location), id: \.self) { point in
            Dot(point: point, size: size)
              .fill(color ?? Color.accentColor)
          }
        }
      }
    }
  }
}

private struct Line: Shape {
  var points: [CGPoint]
  var size: CGSize

  func path(in rect: CGRect) -> Path {
    let pointTransform: CGAffineTransform =
      .identity
      .translatedBy(x: 0.0, y: -1.0)
      .concatenating(.identity.scaledBy(x: 1.0, y: -1.0))
      .concatenating(.identity.scaledBy(x: size.width, y: size.height))
    return Path {
      $0.move(to: points[0])
      for point in points {
        $0.addLine(to: point)
      }
    }.applying(pointTransform)
  }
}

private struct Dot: Shape {
  var point: CGPoint
  var size: CGSize

  func path(in rect: CGRect) -> Path {
    let pointTransform: CGAffineTransform =
      .identity
      .translatedBy(x: 0.0, y: -1.0)
      .concatenating(.identity.scaledBy(x: 1.0, y: -1.0))
      .concatenating(.identity.scaledBy(x: size.width, y: size.height))
    let size = CGSize(width: 20 / size.width, height: 20 / size.height)
    return Path(
      ellipseIn: CGRect(
        origin: CGPoint(x: point.x - size.width / 2, y: point.y - size.height / 2),
        size: size
      )
    ).applying(pointTransform)
  }
}

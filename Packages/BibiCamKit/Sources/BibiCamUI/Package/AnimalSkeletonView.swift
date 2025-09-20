import SwiftUI
import Vision

package struct AnimalSkeletonView: View {
  var animalBodyParts: [VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint]
  var size: CGSize
  var color: Color?
  var isDotsEnabled: Bool

  package init(
    animalBodyParts: [VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint],
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
    Group {
      if animalBodyParts.isEmpty == false {
        ZStack {
          ZStack {
            // left head
            if let nose = animalBodyParts[.nose] {
              if let leftEye = animalBodyParts[.leftEye] {
                Line(points: [nose.location, leftEye.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.orange)
              }
            }
            if let leftEye = animalBodyParts[.leftEye] {
              if let leftEarBottom = animalBodyParts[.leftEarBottom] {
                Line(points: [leftEye.location, leftEarBottom.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.orange)
              }
            }
            if let leftEarBottom = animalBodyParts[.leftEarBottom] {
              if let leftEarMiddle = animalBodyParts[.leftEarMiddle] {
                if let leftEarTop = animalBodyParts[.leftEarTop] {
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
            if let nose = animalBodyParts[.nose] {
              if let rightEye = animalBodyParts[.rightEye] {
                Line(points: [nose.location, rightEye.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.orange)
              }
            }
            if let rightEye = animalBodyParts[.rightEye] {
              if let rightEarBottom = animalBodyParts[.rightEarBottom] {
                Line(points: [rightEye.location, rightEarBottom.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.orange)
              }
            }
            if let rightEarBottom = animalBodyParts[.rightEarBottom] {
              if let rightEarMiddle = animalBodyParts[.rightEarMiddle] {
                if let rightEarTop = animalBodyParts[.rightEarTop] {
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
            if let nose = animalBodyParts[.nose] {
              if let neck = animalBodyParts[.neck] {
                Line(points: [nose.location, neck.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.yellow)
              }
            }
            // tail - The neck to the bottom tail.
            if let neck = animalBodyParts[.neck] {
              if let tailBottom = animalBodyParts[.tailBottom] {
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
            if let neck = animalBodyParts[.neck] {
              if let leftFrontElbow = animalBodyParts[.leftFrontElbow] {
                Line(points: [neck.location, leftFrontElbow.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.purple)
              }
            }
            if let leftFrontElbow = animalBodyParts[.leftFrontElbow] {
              if let leftFrontKnee = animalBodyParts[.leftFrontKnee] {
                if let leftFrontPaw = animalBodyParts[.leftFrontPaw] {
                  Line(points: [leftFrontElbow.location, leftFrontKnee.location, leftFrontPaw.location], size: size)
                    .stroke(lineWidth: 5.0)
                    .fill(color ?? Color.purple)
                }
              }
            }
            // right forelegs
            if let neck = animalBodyParts[.neck] {
              if let rightFrontElbow = animalBodyParts[.rightFrontElbow] {
                Line(points: [neck.location, rightFrontElbow.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.purple)
              }
            }
            if let rightFrontElbow = animalBodyParts[.rightFrontElbow] {
              if let rightFrontKnee = animalBodyParts[.rightFrontKnee] {
                if let rightFrontPaw = animalBodyParts[.rightFrontPaw] {
                  Line(points: [rightFrontElbow.location, rightFrontKnee.location, rightFrontPaw.location], size: size)
                    .stroke(lineWidth: 5.0)
                    .fill(color ?? Color.purple)
                }
              }
            }
            // left hindlegs
            if let tailBottom = animalBodyParts[.tailBottom] {
              if let leftBackElbow = animalBodyParts[.leftBackElbow] {
                Line(points: [tailBottom.location, leftBackElbow.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.blue)
              }
            }
            if let leftBackElbow = animalBodyParts[.leftBackElbow] {
              if let leftBackKnee = animalBodyParts[.leftBackKnee] {
                if let leftBackPaw = animalBodyParts[.leftBackPaw] {
                  Line(points: [leftBackElbow.location, leftBackKnee.location, leftBackPaw.location], size: size)
                    .stroke(lineWidth: 5.0)
                    .fill(color ?? Color.blue)
                }
              }
            }
            // right hindlegs
            if let tailBottom = animalBodyParts[.tailBottom] {
              if let rightBackElbow = animalBodyParts[.rightBackElbow] {
                Line(points: [tailBottom.location, rightBackElbow.location], size: size)
                  .stroke(lineWidth: 5.0)
                  .fill(color ?? Color.blue)
              }
            }
            if let rightBackElbow = animalBodyParts[.rightBackElbow] {
              if let rightBackKnee = animalBodyParts[.rightBackKnee] {
                if let rightBackPaw = animalBodyParts[.rightBackPaw] {
                  Line(points: [rightBackElbow.location, rightBackKnee.location, rightBackPaw.location], size: size)
                    .stroke(lineWidth: 5.0)
                    .fill(color ?? Color.blue)
                }
              }
            }
          }
          ZStack {
            // taols.
            if let tailBottom = animalBodyParts[.tailBottom] {
              if let tailMiddle = animalBodyParts[.tailMiddle] {
                if let tailTop = animalBodyParts[.tailTop] {
                  Line(points: [tailBottom.location, tailMiddle.location, tailTop.location], size: size)
                    .stroke(lineWidth: 5.0)
                    .fill(color ?? Color.orange)
                }
              }
            }
          }
        }
        if isDotsEnabled {
          ForEach(animalBodyParts.map(\.value.location), id: \.self) { point in
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

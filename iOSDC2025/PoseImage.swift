//
//  PoseImage.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/19.
//

import BibiCamKit
import SwiftUI
@preconcurrency import Vision

struct PoseImage: View {
  private var image: NSImage
  private var isSkeletonEnabled: Bool
  private var size: NSSize {
    NSSize(width: image.size.width / image.size.height * 810, height: 810)
  }

  @State private var parts: [VNAnimalBodyPoseObservation.JointName: VNRecognizedPoint] = [:]

  init(image: NSImage, isSkeletonEnabled: Bool) {
    self.image = image
    self.isSkeletonEnabled = isSkeletonEnabled
  }

  var body: some View {
    ZStack(alignment: .center) {
      Image(nsImage: image)
        .resizable()
        .scaledToFit()
        .frame(height: size.height)
      if isSkeletonEnabled, !parts.isEmpty {
        SkeletonPoseScreen(parts: parts, size: size)
          .frame(width: size.width, height: size.height)
      }
    }
    .task {
      let request = VNDetectAnimalBodyPoseRequest()
      let handler = VNImageRequestHandler(cgImage: image.cgImage(forProposedRect: nil, context: nil, hints: nil)!)
      try? handler.perform([request])
      guard let parts = try? request.results?.first?.recognizedPoints(.all) else {
        return
      }
      self.parts = parts
    }
  }
}

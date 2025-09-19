import BibiCamUI
import SwiftUI

public struct NestCamScreen: View {
  private let isSkeletonEnabled: Bool

  public init(isSkeletonEnabled: Bool) {
    self.isSkeletonEnabled = isSkeletonEnabled
  }

  public var body: some View {
    CamScreen(isSkeletonEnabled: isSkeletonEnabled)
  }
}

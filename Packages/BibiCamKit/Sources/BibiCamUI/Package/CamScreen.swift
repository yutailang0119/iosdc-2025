import SwiftUI

package struct CamScreen: View {
  private let dependency: AppDependency
  private let isSkeletonEnabled: Bool

  package init(isSkeletonEnabled: Bool) {
    self.dependency = AppDependency()
    self.isSkeletonEnabled = isSkeletonEnabled
  }

  package var body: some View {
    ContentView(isSkeletonEnabled: isSkeletonEnabled)
      .environment(\.dependency, dependency)
  }
}

private extension CamScreen {
  struct ContentView: View {
    @State private var phase: ScreenPhase<Void, Error> = .loading
    private var isSkeletonEnabled: Bool

    init(isSkeletonEnabled: Bool) {
      self.isSkeletonEnabled = isSkeletonEnabled
    }

    var body: some View {
      DependencyProvider { dependency in
        WebRTCScreen(
          state: WebRTCScreen.ViewState(
            dependency: dependency,
            isSkeletonEnabled: isSkeletonEnabled,
          )
        )
      }
    }
  }
}

#Preview {
  CamScreen(isSkeletonEnabled: true)
}

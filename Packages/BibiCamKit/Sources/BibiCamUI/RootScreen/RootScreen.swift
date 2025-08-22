import SwiftUI

package struct RootScreen: View {
  private let dependency: AppDependency

  package init() {
    self.dependency = AppDependency()
  }

  package var body: some View {
    ContentView()
      .environment(\.dependency, dependency)
  }
}

private extension RootScreen {
  struct ContentView: View {
    @State private var phase: ScreenPhase<Void, Error> = .loading

    var body: some View {
      DependencyProvider { dependency in
        WebRTCScreen(
          state: WebRTCScreen.ViewState(
            dependency: dependency,
            deviceId: ""
          )
        )
      }
    }
  }
}

#Preview {
  RootScreen()
}

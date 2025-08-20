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
        Screen(phase) { _ in
          NavigationSplitView {
            DevicesScreen()
              .toolbar {
                ToolbarItem {
                  Menu {
                    SignOutButton {
                      phase = .empty
                    }
                  } label: {
                    Label("Menu", symbol: .ellipsis)
                  }
                }
              }
          } detail: {
            EmptyView()
          }
        } empty: {
          SignInButton { _ in
            phase = .loaded(())
          }
          .frame(maxWidth: 440)
          .padding()
        }
        .task {
          let smartDeviceManagement = await dependency.smartDeviceManagement
          if smartDeviceManagement != nil {
            self.phase = .loaded(())
          } else {
            self.phase = .empty
          }
        }
      }
    }
  }
}

#Preview {
  RootScreen()
}

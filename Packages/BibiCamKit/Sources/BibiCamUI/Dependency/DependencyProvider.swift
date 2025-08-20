import SwiftUI

struct DependencyProvider<Content: View>: View {
  @Environment(\.dependency) private var dependency: AppDependency?
  let content: (AppDependency) -> Content

  var body: some View {
    if let dependency {
      content(dependency)
    } else {
      #if DEBUG
      ContentUnavailableView {
        Label(
          "AppDependency could not be resolved",
          symbol: .exclamationmark
        )
        .symbolVariant(.circle)
      }
      .foregroundStyle(.red)
      #endif
    }
  }
}

#Preview {
  DependencyProvider { _ in
    EmptyView()
  }
}

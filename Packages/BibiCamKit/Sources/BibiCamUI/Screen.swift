import SwiftUI

enum ScreenPhase<Value, Failure: Swift.Error> {
  case loading
  case empty
  case loaded(Value)
  case failed(Failure)
}

struct Screen<Value, Failure: Swift.Error, Loading: View, Empty: View, Loaded: View, Failed: View>: View {
  private var phase: ScreenPhase<Value, Failure>
  private var loading: () -> Loading
  private var empty: () -> Empty
  private var loaded: (Value) -> Loaded
  private var failed: (Failure) -> Failed

  init(
    _ phase: ScreenPhase<Value, Failure>,
    @ViewBuilder loaded: @escaping (Value) -> Loaded,
    @ViewBuilder loading: @escaping () -> Loading = {
      ProgressView()
    },
    @ViewBuilder empty: @escaping () -> Empty = {
      EmptyView()
    },
    @ViewBuilder failed: @escaping (Failure) -> Failed
  ) {
    self.phase = phase
    self.loading = loading
    self.empty = empty
    self.loaded = loaded
    self.failed = failed
  }

  init(
    _ phase: ScreenPhase<Value, Failure>,
    @ViewBuilder loaded: @escaping (Value) -> Loaded,
    @ViewBuilder loading: @escaping () -> Loading = {
      ProgressView()
    },
    @ViewBuilder empty: @escaping () -> Empty = {
      EmptyView()
    }
  )
  where
    Failed == ContentUnavailableView<
      ScreenUnavailableContent.Label, ScreenUnavailableContent.Description, ScreenUnavailableContent.Actions
    >
  {
    self.phase = phase
    self.loading = loading
    self.empty = empty
    self.loaded = loaded
    self.failed = { error in
      ContentUnavailableView.screen(error: error)
    }
  }

  var body: some View {
    switch phase {
    case .loading:
      loading()
    case .empty:
      empty()
    case .loaded(let value):
      loaded(value)
    case .failed(let error):
      failed(error)
    }
  }
}

struct ListScreen<Value, Failure: Swift.Error, Loading: View, Empty: View, Loaded: View, Failed: View>: View {
  private var phase: ScreenPhase<Value, Failure>
  private var loading: () -> Loading
  private var empty: () -> Empty
  private var loaded: (Value) -> Loaded
  private var failed: (Failure) -> Failed

  init(
    _ phase: ScreenPhase<Value, Failure>,
    @ViewBuilder loaded: @escaping (Value) -> Loaded,
    @ViewBuilder loading: @escaping () -> Loading = {
      ProgressView()
    },
    @ViewBuilder empty: @escaping () -> Empty = {
      EmptyView()
    },
    @ViewBuilder failed: @escaping (Failure) -> Failed
  ) {
    self.phase = phase
    self.loading = loading
    self.empty = empty
    self.loaded = loaded
    self.failed = failed
  }

  init(
    _ phase: ScreenPhase<Value, Failure>,
    @ViewBuilder loaded: @escaping (Value) -> Loaded,
    @ViewBuilder loading: @escaping () -> Loading = {
      ProgressView()
    },
    @ViewBuilder empty: @escaping () -> Empty = {
      EmptyView()
    }
  )
  where
    Failed == ContentUnavailableView<
      ScreenUnavailableContent.Label, ScreenUnavailableContent.Description, ScreenUnavailableContent.Actions
    >
  {
    self.phase = phase
    self.loading = loading
    self.empty = empty
    self.loaded = loaded
    self.failed = { error in
      ContentUnavailableView.screen(error: error)
    }
  }

  var body: some View {
    List {
      switch phase {
      case .loaded(let value):
        loaded(value)
      case .loading,
        .empty,
        .failed:
        EmptyView()
      }
    }
    .overlay {
      switch phase {
      case .loading:
        loading()
      case .empty:
        empty()
      case .loaded:
        EmptyView()
      case .failed(let error):
        failed(error)
      }
    }
  }
}

struct ScreenUnavailableContent {
  struct Label: View {
    let error: Error

    var body: some View {
      SwiftUI.Label {
        Text(error.title)
      } icon: {
        Image(symbol: .exclamationmark)
          .symbolVariant(.circle)
      }
    }
  }

  struct Description: View {
    let error: Error

    var body: some View {
      Text(error.description)
    }
  }

  struct Actions: View {
    var body: some View {
      EmptyView()
    }
  }
}

extension ContentUnavailableView
where
  Label == ScreenUnavailableContent.Label, Description == ScreenUnavailableContent.Description,
  Actions == ScreenUnavailableContent.Actions
{
  static func screen(
    error: Error
  ) -> ContentUnavailableView<
    ScreenUnavailableContent.Label, ScreenUnavailableContent.Description, ScreenUnavailableContent.Actions
  > {
    ContentUnavailableView {
      ScreenUnavailableContent.Label(error: error)
    } description: {
      ScreenUnavailableContent.Description(error: error)
    } actions: {
      ScreenUnavailableContent.Actions()
    }
  }
}

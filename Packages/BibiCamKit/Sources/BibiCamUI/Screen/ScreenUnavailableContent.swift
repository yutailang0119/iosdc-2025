import Foundation
import SwiftUI

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
  Label == ScreenUnavailableContent.Label,
  Description == ScreenUnavailableContent.Description,
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

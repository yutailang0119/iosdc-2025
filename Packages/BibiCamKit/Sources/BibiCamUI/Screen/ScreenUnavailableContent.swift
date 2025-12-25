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
}

extension ContentUnavailableView
where
  Label == ScreenUnavailableContent.Label,
  Description == ScreenUnavailableContent.Description,
  Actions == EmptyView
{
  static func screen(
    error: Error
  ) -> ContentUnavailableView<
    ScreenUnavailableContent.Label, ScreenUnavailableContent.Description, EmptyView,
  > {
    ContentUnavailableView {
      ScreenUnavailableContent.Label(error: error)
    } description: {
      ScreenUnavailableContent.Description(error: error)
    } actions: {
      EmptyView()
    }
  }
}

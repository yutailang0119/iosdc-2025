import Foundation
import SwiftUI

enum SFSymbol: String {
  case exclamationmark
}

extension SwiftUI.Image {
  init(symbol: SFSymbol) {
    self.init(systemName: symbol.rawValue)
  }
}

extension SwiftUI.Label where Title == Text, Icon == Image {
  init(_ title: String, symbol: SFSymbol) {
    self.init(title, systemImage: symbol.rawValue)
  }
}

extension SwiftUI.Label where Icon == Image {
  init(title: () -> Title, symbol: SFSymbol) {
    self.init(title: title, icon: { Image(symbol: symbol) })
  }
}

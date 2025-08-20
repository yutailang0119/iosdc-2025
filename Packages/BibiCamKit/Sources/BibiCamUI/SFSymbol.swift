import Foundation
import SwiftUI

public enum SFSymbol: String {
  case ellipsis
  case exclamationmark
  case person
  case play
  case stop
  case webCamera = "web.camera"
}

extension SwiftUI.Image {
  public init(symbol: SFSymbol) {
    self.init(systemName: symbol.rawValue)
  }
}

extension SwiftUI.Label where Title == Text, Icon == Image {
  public init(_ title: String, symbol: SFSymbol) {
    self.init(title, systemImage: symbol.rawValue)
  }
}

extension SwiftUI.Label where Icon == Image {
  public init(title: () -> Title, symbol: SFSymbol) {
    self.init(title: title, icon: { Image(symbol: symbol) })
  }
}

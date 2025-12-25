import Foundation

enum ScreenPhase<Value, Failure: Swift.Error> {
  case loading
  case empty
  case loaded(Value)
  case failed(Failure)
}

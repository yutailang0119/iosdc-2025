import Foundation

extension Error {
  var title: String {
    switch self {
    default:
      return "Error"
    }
  }

  var description: String {
    switch self {
    default:
      return localizedDescription
    }
  }
}

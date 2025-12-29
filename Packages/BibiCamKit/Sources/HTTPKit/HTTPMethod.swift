import Foundation

package enum HTTPMethod: Sendable {
  case get(queries: [URLQueryItem]?)
  case post(body: Body)

  var raw: String {
    switch self {
    case .get: "GET"
    case .post: "POST"
    }
  }
}

extension HTTPMethod {
  package enum Body: Sendable {
    case formUrlencoded(queries: [URLQueryItem])
    case json(any Encodable & Sendable)
  }
}

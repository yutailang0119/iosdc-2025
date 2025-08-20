import Foundation

package protocol Request: Sendable {
  associatedtype Response: Decodable, Sendable
  var root: URL { get }
  var headers: [String: String] { get }
  var method: HTTPMethod { get }
  var path: String { get }
  var queryItems: [URLQueryItem]? { get }
  var body: Data? { get }
  var urlRequest: URLRequest { get }
}

package extension Request {
  var headers: [String: String] {
    switch method {
    case .get:
      return [:]
    case .post(.formUrlencoded):
      return ["Content-Type": "application/x-www-form-urlencoded"]
    case .post(.json):
      return ["Content-Type": "application/json"]
    }
  }

  var queryItems: [URLQueryItem]? {
    switch method {
    case .get(let queries):
      return queries
    case .post:
      return nil
    }
  }

  var body: Data? {
    switch method {
    case .get:
      return nil
    case .post(.formUrlencoded(let queries)):
      var components = URLComponents()
      components.queryItems = queries
      return components.query?.data(using: .utf8)
    case .post(.json(let payload)):
      return try? JSONEncoder().encode(payload)
    }
  }

  var urlRequest: URLRequest {
    var components = URLComponents(
      url: root,
      resolvingAgainstBaseURL: false
    )
    components?.path += path
    components?.queryItems = queryItems?
      .filter { $0.value != nil }
    guard let url = components?.url else {
      fatalError()
    }
    var request = URLRequest(url: url)
    request.httpMethod = method.raw
    request.allHTTPHeaderFields = headers
    request.httpBody = body
    return request
  }
}

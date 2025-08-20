import Foundation

package enum APIError: Error {
  case connection(error: Error)
  case request(error: Error)
  case response(error: ResponseError)
}

extension APIError: CustomStringConvertible {
  var title: String {
    switch self {
    case .connection:
      return "Connection Error"
    case .request:
      return "Request Error"
    case .response:
      return "Response Error"
    }
  }

  package var description: String {
    switch self {
    case .connection(let error):
      return error.localizedDescription
    case .request(let error):
      return error.localizedDescription
    case .response(let responseError):
      return responseError.description
    }
  }
}

package enum ResponseError: Error {
  case nonHTTPURLResponse(URLResponse?)
  case unacceptableStatusCode(statusCode: Int, response: Response?)
  case unexpectedObject(Error)
}

extension ResponseError {
  package struct Response: Error, Decodable, Sendable {
    package let error: ErrorResponse
  }
}

extension ResponseError.Response {
  package struct ErrorResponse: Decodable, Sendable {
    package let code: Int
    package let message: String
    package let status: String
  }
}

extension ResponseError: CustomStringConvertible {
  package var description: String {
    switch self {
    case .nonHTTPURLResponse:
      return "Catch Non HTTP URL Response"
    case .unacceptableStatusCode(let statusCode, let response):
      let message = response.flatMap({ "\($0.error.status) \($0.error.message)" })
      return "\(statusCode): \(message ?? HTTPURLResponse.localizedString(forStatusCode: statusCode))"
    case .unexpectedObject(let error):
      return error.localizedDescription
    }
  }
}

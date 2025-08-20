import Foundation

package protocol APIClient: Sendable {
  associatedtype Session
  var session: Session { get }
  var decoder: JSONDecoder { get }
  func request<R: Request>(for request: R) async throws -> R.Response
}

package extension APIClient where Session == URLSession {
  func request<R: Request>(for request: R) async throws -> R.Response {
    func data(
      for request: R
    ) async throws(APIError) -> (data: Data, response: URLResponse) {
      do {
        return try await session.data(for: request.urlRequest)
      } catch {
        throw APIError.connection(error: error)
      }
    }
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws(APIError) -> T {
      do {
        return try decoder.decode(type.self, from: data)
      } catch {
        throw APIError.response(error: .unexpectedObject(error))
      }
    }

    let (data, response) = try await data(for: request)
    guard let httpResponse = response as? HTTPURLResponse else {
      throw APIError.response(error: .nonHTTPURLResponse(response))
    }
    guard 200..<300 ~= httpResponse.statusCode else {
      throw APIError.response(
        error: .unacceptableStatusCode(
          statusCode: httpResponse.statusCode,
          response: try? decode(ResponseError.Response.self, from: data)
        )
      )
    }
    return try decode(R.Response.self, from: data)
  }
}

import Foundation
import HTTPKit

package struct CommandPayload<Params: Encodable & Sendable>: Encodable, Sendable {
  public let command: String
  public let params: Params

  package init(command: String, params: Params) {
    self.command = command
    self.params = params
  }
}

package protocol ExecuteCommandRequest: Request {
  associatedtype Params: Encodable & Sendable
  var projectID: String { get }
  var deviceID: String { get }
  var payload: CommandPayload<Params> { get }
}

extension ExecuteCommandRequest {
  package var method: HTTPMethod {
    .post(body: .json(payload))
  }

  package var path: String {
    "/devices/\(deviceID):executeCommand"
  }
}

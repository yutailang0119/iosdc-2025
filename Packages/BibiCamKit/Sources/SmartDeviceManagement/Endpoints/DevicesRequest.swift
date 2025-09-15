import Foundation
import HTTPKit

package struct DevicesRequest: Request {
  package let projectId: String

  package init(projectId: String) {
    self.projectId = projectId
  }

  package var method: HTTPMethod {
    .get(queries: [])
  }

  package var path: String {
    "/devices"
  }
}

extension DevicesRequest {
  package struct Response: Decodable, Sendable {
    package let devices: [Device]
  }
}

extension DevicesRequest.Response {
  package struct Device: Decodable, Sendable {
    package let name: String
    package let deviceType: String
    package let traits: Traits
    package let parentRelations: [ParentRelation]

    private enum CodingKeys: String, CodingKey {
      case name
      case deviceType = "type"
      case traits
      case parentRelations
    }
  }
}

extension DevicesRequest.Response.Device {
  package struct Traits: Decodable, Sendable {
    package let info: Info
    package let cameraLiveStream: CameraLiveStream

    private enum CodingKeys: String, CodingKey {
      case info = "sdm.devices.traits.Info"
      case cameraLiveStream = "sdm.devices.traits.CameraLiveStream"
    }
  }
}

extension DevicesRequest.Response.Device.Traits {
  package struct Info: Decodable, Sendable {
    package let customName: String
  }

  package struct CameraLiveStream: Decodable, Sendable {
    package let supportedProtocols: [String]
  }
}

extension DevicesRequest.Response.Device {
  package struct ParentRelation: Decodable, Sendable {
    package let parent: String
    package let displayName: String
  }
}

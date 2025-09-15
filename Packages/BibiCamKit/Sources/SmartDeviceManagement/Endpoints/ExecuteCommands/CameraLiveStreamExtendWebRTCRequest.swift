import Foundation

package struct CameraLiveStreamExtendWebRTCRequest: ExecuteCommandRequest {
  package let projectId: String
  package let deviceId: String
  private let mediaSessionId: String

  package init(
    projectId: String,
    deviceId: String,
    mediaSessionId: String
  ) {
    self.projectId = projectId
    self.deviceId = deviceId
    self.mediaSessionId = mediaSessionId
  }

  package var payload: CommandPayload<Params> {
    CommandPayload(
      command: "sdm.devices.commands.CameraLiveStream.ExtendWebRtcStream",
      params: Params(mediaSessionId: mediaSessionId)
    )
  }

  package var commend: String {
    "sdm.devices.commands.CameraLiveStream.ExtendWebRtcStream"
  }
}

extension CameraLiveStreamExtendWebRTCRequest {
  package struct Params: Encodable, Sendable {
    package let mediaSessionId: String
  }
}

extension CameraLiveStreamExtendWebRTCRequest {
  package struct Response: Decodable, Sendable {
    package let results: Results
  }
}

extension CameraLiveStreamExtendWebRTCRequest.Response {
  package struct Results: Decodable, Sendable {
    package let mediaSessionId: String
    package let expiresAt: Date?

    private enum CodingKeys: CodingKey {
      case mediaSessionId
      case expiresAt
    }

    package init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.mediaSessionId = try container.decode(String.self, forKey: CodingKeys.mediaSessionId)
      self.expiresAt = try container.decodeIfPresent(String.self, forKey: CodingKeys.expiresAt)
        .flatMap {
          let formatter = ISO8601DateFormatter()
          formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
          return formatter.date(from: $0)
        }
    }
  }
}

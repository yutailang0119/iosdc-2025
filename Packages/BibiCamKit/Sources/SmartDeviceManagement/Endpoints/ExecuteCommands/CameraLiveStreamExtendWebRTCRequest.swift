import Foundation

package struct CameraLiveStreamExtendWebRTCRequest: ExecuteCommandRequest {
  package let projectID: String
  package let deviceID: String
  private let mediaSessionID: String

  package init(
    projectID: String,
    deviceID: String,
    mediaSessionID: String
  ) {
    self.projectID = projectID
    self.deviceID = deviceID
    self.mediaSessionID = mediaSessionID
  }

  package var payload: CommandPayload<Params> {
    CommandPayload(
      command: "sdm.devices.commands.CameraLiveStream.ExtendWebRtcStream",
      params: Params(mediaSessionID: mediaSessionID)
    )
  }

  package var commend: String {
    "sdm.devices.commands.CameraLiveStream.ExtendWebRtcStream"
  }
}

extension CameraLiveStreamExtendWebRTCRequest {
  package struct Params: Encodable, Sendable {
    package let mediaSessionID: String
  }
}

extension CameraLiveStreamExtendWebRTCRequest {
  package struct Response: Decodable, Sendable {
    package let results: Results
  }
}

extension CameraLiveStreamExtendWebRTCRequest.Response {
  package struct Results: Decodable, Sendable {
    package let mediaSessionID: String
    package let expiresAt: Date?

    private enum CodingKeys: String, CodingKey {
      case mediaSessionID = "mediaSessionId"
      case expiresAt
    }

    package init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.mediaSessionID = try container.decode(String.self, forKey: CodingKeys.mediaSessionID)
      self.expiresAt = try container.decodeIfPresent(String.self, forKey: CodingKeys.expiresAt)
        .flatMap {
          let formatter = ISO8601DateFormatter()
          formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
          return formatter.date(from: $0)
        }
    }
  }
}

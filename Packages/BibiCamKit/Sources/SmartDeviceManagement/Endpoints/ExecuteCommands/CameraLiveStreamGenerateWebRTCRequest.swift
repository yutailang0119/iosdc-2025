import Foundation

package struct CameraLiveStreamGenerateWebRTCRequest: ExecuteCommandRequest {
  package let projectID: String
  package let deviceID: String
  private let offerSdp: String

  package init(
    projectID: String,
    deviceID: String,
    offerSdp: String
  ) {
    self.projectID = projectID
    self.deviceID = deviceID
    self.offerSdp = offerSdp
  }

  package var payload: CommandPayload<Params> {
    CommandPayload(
      command: "sdm.devices.commands.CameraLiveStream.GenerateWebRtcStream",
      params: Params(offerSdp: offerSdp)
    )
  }
}

extension CameraLiveStreamGenerateWebRTCRequest {
  package struct Params: Encodable, Sendable {
    package let offerSdp: String
  }
}

extension CameraLiveStreamGenerateWebRTCRequest {
  package struct Response: Decodable, Sendable {
    package let results: Results
  }
}

extension CameraLiveStreamGenerateWebRTCRequest.Response {
  package struct Results: Decodable, Sendable {
    package let answerSdp: String
    package let mediaSessionID: String
    package let expiresAt: Date?

    private enum CodingKeys: String, CodingKey {
      case answerSdp
      case mediaSessionID = "mediaSessionId"
      case expiresAt
    }

    package init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.answerSdp = try container.decode(String.self, forKey: CodingKeys.answerSdp)
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

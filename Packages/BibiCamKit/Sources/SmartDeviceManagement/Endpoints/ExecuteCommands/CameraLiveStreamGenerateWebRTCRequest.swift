import Foundation

package struct CameraLiveStreamGenerateWebRTCRequest: ExecuteCommandRequest {
  package let projectId: String
  package let deviceId: String
  private let offerSdp: String

  package init(
    projectId: String,
    deviceId: String,
    offerSdp: String
  ) {
    self.projectId = projectId
    self.deviceId = deviceId
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
    package let mediaSessionId: String
    package let expiresAt: Date?

    private enum CodingKeys: CodingKey {
      case answerSdp
      case mediaSessionId
      case expiresAt
    }

    package init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.answerSdp = try container.decode(String.self, forKey: CodingKeys.answerSdp)
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

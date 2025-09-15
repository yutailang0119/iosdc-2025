import Foundation

package struct CameraLiveStreamStopWebRTCRequest: ExecuteCommandRequest {
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
      command: "sdm.devices.commands.CameraLiveStream.StopWebRtcStream",
      params: Params(mediaSessionId: mediaSessionId)
    )
  }
}

extension CameraLiveStreamStopWebRTCRequest {
  package struct Params: Encodable, Sendable {
    package let mediaSessionId: String
  }
}

extension CameraLiveStreamStopWebRTCRequest {
  package struct Response: Decodable, Sendable {}
}

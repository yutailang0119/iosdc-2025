import Foundation

package struct CameraLiveStreamStopWebRTCRequest: ExecuteCommandRequest {
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
      command: "sdm.devices.commands.CameraLiveStream.StopWebRtcStream",
      params: Params(mediaSessionID: mediaSessionID)
    )
  }
}

extension CameraLiveStreamStopWebRTCRequest {
  package struct Params: Encodable, Sendable {
    package let mediaSessionID: String
  }
}

extension CameraLiveStreamStopWebRTCRequest {
  package struct Response: Decodable, Sendable {}
}

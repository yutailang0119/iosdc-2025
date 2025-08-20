import Foundation
import HTTPKit

package struct SmartDeviceManagementAPI: APIClient {
  package let session: URLSession
  package var decoder: JSONDecoder

  package init(token: String) {
    let configration = URLSessionConfiguration.default
    configration.httpAdditionalHeaders = [
      "Authorization": "Bearer \(token)",
      "User-Agent": "BibiCam.app",
    ]
    self.session = URLSession(configuration: configration)
    let decoder = JSONDecoder()
    self.decoder = decoder
  }
}

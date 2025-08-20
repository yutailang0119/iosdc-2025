import Foundation
import HTTPKit

package extension Request {
  var root: URL {
    let projectId = ""
    return URL(string: "https://smartdevicemanagement.googleapis.com/v1/enterprises/\(projectId)")!
  }
}

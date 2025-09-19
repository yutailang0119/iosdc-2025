import Foundation
import HTTPKit
import SmartDeviceManagement
import SwiftUI

struct AppDependency {
  var projectId: String {
    ""
  }

  var nestCamId: String {
    ""
  }

  var smartDeviceManagement: (any APIClient)? {
    get async {
      SmartDeviceManagementAPI(
        token: ""
      )
    }
  }
}

private struct AppDependencyKey: EnvironmentKey {
  static var defaultValue: AppDependency? { nil }
}

extension EnvironmentValues {
  var dependency: AppDependency? {
    get {
      self[AppDependencyKey.self]
    }
    set {
      self[AppDependencyKey.self] = newValue
    }
  }
}

import Foundation
import GoogleSignIn
import HTTPKit
import SmartDeviceManagement
import SwiftUI

struct AppDependency {
  var smartDeviceManagement: (any APIClient)? {
    get async {
      do {
        let user = try await GIDSignIn.sharedInstance.restorePreviousSignIn()
        guard user.accessToken.expirationDate.map({ $0 > Date() }) ?? false,
          user.grantedScopes?.contains(GIDSignIn.scopes) ?? false
        else {
          return nil
        }
        return SmartDeviceManagementAPI(token: user.accessToken.tokenString)
      } catch {
        return nil
      }
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

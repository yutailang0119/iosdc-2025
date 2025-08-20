import GoogleSignIn
import SwiftUI

struct SignOutButton: View {
  var action: @MainActor () -> Void

  var body: some View {
    Button(role: .destructive) {
      GIDSignIn.sharedInstance.signOut()
      action()
    } label: {
      Label("Sign out", symbol: .person)
    }
  }
}

@preconcurrency import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

struct SignInButton: UIViewControllerRepresentable {
  var action: (GIDSignInResult) -> Void

  func makeCoordinator() -> () {}

  func makeUIViewController(context: Context) -> some UIViewController {
    SignInViewController(
      rootView: SignInViewController.ContentView {
        action($0)
      }
    )
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

private final class SignInViewController: UIHostingController<SignInViewController.ContentView> {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.rootView.rootViewController = self
  }
}

extension SignInViewController {
  struct ContentView: View {
    var action: (GIDSignInResult) -> Void
    var rootViewController: UIViewController!

    var body: some View {
      GoogleSignInButton {
        Task {
          let result = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: rootViewController,
            hint: nil,
            additionalScopes: GIDSignIn.scopes
          )
          action(result)
        }
      }
    }
  }
}

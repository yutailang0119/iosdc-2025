//
//  ReferencesSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/28.
//

import SlideKit
import SwiftUI

@Slide
struct ReferencesSlide: View {
  enum SlidePhasedState: Int, PhasedState {
    case initial, second
  }

  @Phase var phase: SlidePhasedState

  var body: some View {
    HeaderSlide("References") {
      switch phase {
      case .initial:
        Item("Le Chat blanc - Pierre Bonnard | Musée d'Orsay") {
          Item {
            Link(
              destination: URL(string: "https://www.musee-orsay.fr/fr/oeuvres/le-chat-blanc-8019")!
            ) {
              Text("https://www.musee-orsay.fr/fr/oeuvres/le-chat-blanc-8019")
                .multilineTextAlignment(.leading)
                .underline()
            }
          }
        }
        Item("Vision | Apple Developer Documentation") {
          Item {
            Link(
              destination: URL(string: "https://developer.apple.com/documentation/vision")!
            ) {
              Text("https://developer.apple.com/documentation/vision")
                .multilineTextAlignment(.leading)
                .underline()
            }
          }
        }
        Item("Detect animal poses in Vision - WWDC23 - Videos - Apple Developer") {
          Item {
            Link(
              destination: URL(string: "https://developer.apple.com/videos/play/wwdc2023/10045/")!
            ) {
              Text("https://developer.apple.com/videos/play/wwdc2023/10045/")
                .multilineTextAlignment(.leading)
                .underline()
            }
          }
        }
        Item("Detecting animal body poses with Vision | Apple Developer Documentation") {
          Item {
            Link(
              destination: URL(
                string: "https://developer.apple.com/documentation/vision/detecting-animal-body-poses-with-vision"
              )!
            ) {
              Text("https://developer.apple.com/documentation/vision/detecting-animal-body-poses-with-vision")
                .multilineTextAlignment(.leading)
                .underline()
            }
          }
        }
      case .second:
        Item {
          Label {
            Link(
              destination: URL(string: "https://github.com/yutailang0119/iosdc-2025")!
            ) {
              Text("yutailang0119/iosdc-2025")
                .multilineTextAlignment(.leading)
            }
          } icon: {
            Image(.gitHub)
              .resizable()
              .scaledToFit()
              .frame(width: 52, height: 52)
          }
        }
        Item("Visionフレームワークを活用した猫のポーズ検出") {
          Item {
            Link(
              destination: URL(string: "https://yutailang0119.hatenablog.com/entry/2023/12/01/000000")!
            ) {
              Text("https://yutailang0119.hatenablog.com/entry/2023/12/01/000000")
                .multilineTextAlignment(.leading)
                .underline()
            }
          }
        }
        Item("iOSアプリでGoogle Smart Device Management APIを使う (2025)") {
          Item {
            Link(
              destination: URL(string: "https://yutailang0119.hatenablog.com/entry/2025/01/19/180000")!
            ) {
              Text("https://yutailang0119.hatenablog.com/entry/2025/01/19/180000")
                .multilineTextAlignment(.leading)
                .underline()
            }
          }
        }
        Item("iOSアプリでGoogle Nest CamにWebRTC接続") {
          Item {
            Link(
              destination: URL(string: "https://yutailang0119.hatenablog.com/entry/2025/07/04/100000")!
            ) {
              Text("https://yutailang0119.hatenablog.com/entry/2025/07/04/100000")
                .multilineTextAlignment(.leading)
                .underline()
            }
          }
        }
      }
    }
  }

  var script: String {
    switch phase {
    case .initial:
      """
      Vision frameworkについては、WWDC23のビデオとサンプルコードを参考にしています
      """
    case .second:
      """
      スライドプロジェクトは、GitHubリポジトリとして公開しています
      うちのカメラに繋げる部分は公開していません
      そのほか、いくつかのブログエントリにもしているので、参照ください
      """
    }
  }
}

#Preview {
  SlidePreview {
    ReferencesSlide()
  }
}

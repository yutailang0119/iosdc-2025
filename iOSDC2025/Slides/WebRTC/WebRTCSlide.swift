//
//  WebRTCSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/18.
//

import SlideKit
import SwiftUI

@Slide
struct WebRTCSlide: View {
  var body: some View {
    HeaderSlide("WebRTC") {
      Item("Web Real-Time Communication")
      Item {
        Link(
          destination: URL(string: "https://webrtc.org")!
        ) {
          Text("https://webrtc.org")
            .multilineTextAlignment(.leading)
            .underline()
        }
      }
      Item("Open Source Software") {
        Item("Appleプラットフォームアプリをサポート")
      }
      Item("公式バイナリは配布停止") {
        Item("Ninjaでコンパイル") {
          Item {
            Link(
              destination: URL(string: "https://webrtc.googlesource.com/src/+/main/docs/native-code/ios/")!
            ) {
              Text("https://webrtc.googlesource.com/src/+/main/docs/native-code/ios/")
                .multilineTextAlignment(.leading)
                .underline()
            }
          }
        }
        Item {
          Label {
            Link(
              destination: URL(string: "https://github.com/stasel/WebRTC")!
            ) {
              Text("stasel/WebRTC")
                .multilineTextAlignment(.leading)
            }
          } icon: {
            Image(.gitHub)
              .resizable()
              .scaledToFit()
              .frame(width: 52, height: 52)
          }
        }
      }
    }
    .background(.background)
  }

  var script: String {
    """
    OSSで開発されているWebRTCは、Appleプラットフォームアプリでの実行をサポートしています
    公式でのバイナリ配布は停止しているので、自身でコンパイルするか、3rd-partyのxcframeworkを使用するとよいでしょう
    """
  }
}

#Preview {
  SlidePreview {
    WebRTCSlide()
  }
}

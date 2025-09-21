//
//  CoverSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/26.
//

import SlideKit
import SwiftUI

@Slide
struct CoverSlide: View {
  var body: some View {
    CenteringSlide {
      VStack(spacing: 100) {
        VStack {
          Text(
            """
            猫と暮らす
            ネットワークカメラ生活🐈
            """
          )
          .font(.system(size: 120, weight: .bold, design: .default))
          .foregroundColor(.primary)
          .multilineTextAlignment(.center)
          Text(verbatim: "~Vision frameworkでペットを愛でよう~")
            .font(.system(size: 80, weight: .bold, design: .default))
            .foregroundColor(.primary)
        }
        VStack(spacing: 40) {
          Text("Yutaro Muta @yutailang0119")
            .font(.system(size: 80, weight: .bold, design: .default))
            .foregroundColor(.accentColor)
          VStack(spacing: 20) {
            Text("2025/09/21 16:20〜 iOSDC Japan 2025")
              .font(.system(size: 60, weight: .medium, design: .default))
              .foregroundColor(.secondary)
            Link(
              destination: URL(
                string: "https://fortee.jp/iosdc-japan-2025/proposal/292e2ec3-d74b-49a6-a8cb-63c2883d589e"
              )!
            ) {
              Text("https://fortee.jp/iosdc-japan-2025/proposal/292e2ec3-d74b-49a6-a8cb-63c2883d589e")
                .multilineTextAlignment(.center)
                .underline()
            }
            .font(.system(size: 32, weight: .medium, design: .default))
            .underline()
          }
        }
      }
    }
    .background(.background)
  }

  var shouldHideIndex: Bool {
    true
  }
}

#Preview {
  SlidePreview {
    CoverSlide()
  }
}

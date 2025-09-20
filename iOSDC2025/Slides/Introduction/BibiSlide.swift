//
//  BibiSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/27.
//

import SlideKit
import SwiftUI

@Slide
struct BibiSlide: View {
  var body: some View {
    SplitSlide {
      HeaderSlide("ビビ") {
        Item("本日の主役") {
          Item("yutailang0119の飼い猫")
        }
        Item("茶トラ")
        Item("オス")
        Item("9歳 (推定)") {
          Item("元野良猫 (保護猫)")
        }
        Item {
          Label {
            Link(
              destination: URL(string: "https://www.instagram.com/bibid_bibi/")!
            ) {
              Text("@bibid_bibi")
                .multilineTextAlignment(.leading)
            }
          } icon: {
            Image(.instagramLogo)
              .resizable()
              .scaledToFit()
              .frame(width: 52, height: 52)
          }
        }
      }
    } detail: {
      CenteringSlide {
        Image(.bibi)
          .resizable()
          .scaledToFit()
          .frame(width: 720, height: 720)
      }
    }
    .background(.background)
  }

  var script: String {
    """
    本日の主役は、うちの飼い猫のビビです
    茶トラのオス
    最近、instagramを始めました
    """
  }
}

#Preview {
  SlidePreview {
    BibiSlide()
  }
}

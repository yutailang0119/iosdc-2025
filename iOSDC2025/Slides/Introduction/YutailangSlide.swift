//
//  YutailangSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/26.
//

import SlideKit
import SwiftUI

@Slide
struct YutailangSlide: View {
  var body: some View {
    SplitSlide {
      HeaderSlide("yutailang0119") {
        Item("世話係 (飼い主)")
        Item("株式会社はてな") {
          Item("京都オフィス")
          Item("アプリケーションエンジニア")
        }
        Item {
          Label {
            Text("try! Swift Tokyo")
          } icon: {
            Image(.riko)
              .resizable()
              .scaledToFit()
              .frame(width: 52, height: 52)
          }
        }
        Item {
          Label {
            Text("AVP座談会")
          } icon: {
            Image(systemName: "vision.pro")
          }
        }
      }
    } detail: {
      CenteringSlide {
        Image(.yutailang0119)
          .resizable()
          .scaledToFit()
          .frame(width: 720, height: 720)
      }
    }
    .background(.background)
  }

  var script: String {
    """
    こんにちは、yutailang0119です
    """
  }
}

#Preview {
  SlidePreview {
    YutailangSlide()
  }
}

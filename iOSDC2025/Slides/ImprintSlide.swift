//
//  ImprintSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/28.
//

import SlideKit
import SwiftUI
import TipKit

@Slide
struct ImprintSlide: View {
  var body: some View {
    CenteringSlide {
      VStack {
        TipView(SpeechBubbleTip(), arrowEdge: .bottom)
          .tipViewStyle(SpeechBubbleTipViewStyle())
        Image(.ebibi)
          .resizable()
          .scaledToFit()
          .frame(width: 720, height: 720)
      }
    }
    .background(.background)
    .task {
      try? Tips.configure()
    }
  }

  var script: String {
    """
    ありがとうございました
    """
  }

  var shouldHideIndex: Bool {
    true
  }
}

private extension ImprintSlide {
  struct SpeechBubbleTip: Tip {
    var title: Text {
      Text("Enjoy iOSDC, Thanks!")
    }
  }

  struct SpeechBubbleTipViewStyle: TipViewStyle {
    func makeBody(configuration: TipViewStyle.Configuration) -> some View {
      configuration.title?.font(.system(size: 120))
        .padding()
    }
  }
}

#Preview {
  SlidePreview {
    ImprintSlide()
  }
}

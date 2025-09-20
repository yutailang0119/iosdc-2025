//
//  BonyarSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/19.
//

import SlideKit
import SwiftUI

@Slide
struct BonyarSlide: View {
  var body: some View {
    HeaderSlide("通称: ボニャール") {
      Item("4つの脚を伸ばす")
      Item("背を縮め、丸める")
    }
    .background(.background)
  }

  var script: String {
    """
    ボニャールは「4つの脚を伸ばし、背を縮め、丸めた体勢」を指します
    猫は日常の中で時たまボニャールしますが、一瞬の出来事なので、きれいな画角に収めることができるかは運次第です
    """
  }
}

#Preview {
  SlidePreview {
    BonyarSlide()
  }
}

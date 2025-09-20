//
//  TitleSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/28.
//

import SwiftUI

struct TitleSlide: View {
  var text: String

  var body: some View {
    Text(text)
      .font(.system(size: 160, weight: .bold, design: .default))
      .foregroundColor(.primary)
      .multilineTextAlignment(.center)
  }
}

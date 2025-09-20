//
//  SplitSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/26.
//

import SwiftUI

struct SplitSlide<Content, Detail>: View where Content: View, Detail: View {
  var content: () -> Content
  var detail: () -> Detail

  var body: some View {
    HStack {
      content()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      detail()
        .background(.gray)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

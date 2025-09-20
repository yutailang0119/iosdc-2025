//
//  CenteringSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/26.
//

import SwiftUI

struct CenteringSlide<Content>: View where Content: View {
  var content: () -> Content

  var body: some View {
    content()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

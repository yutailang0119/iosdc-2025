//
//  ImageSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/08/28.
//

import SwiftUI

struct ImageSlide: View {
  var image: Image

  var body: some View {
    image
      .resizable()
      .scaledToFit()
      .frame(maxHeight: 810)
  }
}

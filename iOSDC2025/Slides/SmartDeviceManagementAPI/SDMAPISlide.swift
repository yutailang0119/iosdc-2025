//
//  SDMAPISlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct SDMAPISlide: View {
  var body: some View {
    HeaderSlide("Smart Device Management API") {
      Item("SDM API") {
        Item("smartdevicemanagement.googleapis.com")
      }
      Item("Nestデバイスにアクセス、操作、管理") {
        Item("Thermostat、Cam、Doorbell、Hub Max...")
      }
      Item("⚠️ 登録料 US$5+tax 必要")
    }
    .background(.background)
  }

  var script: String {
    """
    Smart Device Management APIの設定を行います
    登録料として、初回に$5必要なので注意
    """
  }
}

#Preview {
  SlidePreview {
    SDMAPISlide()
  }
}

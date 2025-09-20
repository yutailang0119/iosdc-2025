//
//  OAuthStepsSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/08.
//

import SlideKit
import SwiftUI

@Slide
struct OAuthStepsSlide: View {
  var body: some View {
    HeaderSlide("Google Cloud OAuth 2.0 (Google Sign-In)") {
      Item("APIの認証にGoogle Cloudを経由")
      Item("Google Cloudプロジェクトを作成")
      Item("Smart Device Management APIを有効化")
      Item("OAuth 2.0 Client IDの作成") {
        Item("OAuthクライアントにiOSを選択")
        Item("Bundle IDを入力")
      }
      Item("アプリからはGoogle Sign-In")
    }
    .background(.background)
  }

  var script: String {
    """
    Google Cloud OAuth 2.0でAPIを認証するための準備、
    """
  }
}

#Preview {
  SlidePreview {
    OAuthStepsSlide()
  }
}

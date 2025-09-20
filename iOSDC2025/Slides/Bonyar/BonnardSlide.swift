//
//  BonnardSlide.swift
//  iOSDC2025
//
//  Created by Yutaro Muta on 2025/09/19.
//

import SlideKit
import SwiftUI

@Slide
struct BonnardSlide: View {
  var body: some View {
    HeaderSlide("Le Chat blanc - Pierre Bonnard") {
      CenteringSlide {
        AsyncImage(
          url: URL(string: "https://cdn.mediatheque.epmoo.fr/link/3c9igq/xlv1bxpq1tglnq8.jpg")
        ) {
          switch $0 {
          case .empty:
            ProgressView()
          case .success(let image):
            HStack(alignment: .bottom) {
              image
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 810)
              VStack(alignment: .leading) {
                Text(
                  """
                  Pierre Bonnard
                  Le Chat blanc
                  1894
                  huile sur carton
                  H. 51,9 ; L. 33,5 cm.
                  Achat, 1982
                  © GrandPalaisRmn (musée d'Orsay) / Franck Raux
                  """
                )
                Link(
                  destination: URL(string: "https://www.musee-orsay.fr/fr/oeuvres/le-chat-blanc-8019")!
                ) {
                  Text("musee-orsay.fr")
                }
              }
              .font(.title3)
              .foregroundColor(.primary)
            }
          case .failure(let error):
            ContentUnavailableView {
              Text(error.localizedDescription)
            }
          @unknown default:
            EmptyView()
          }
        }
      }
    }
    .background(.background)
  }

  var script: String {
    """
    もちろん、猫はすべてがかわいいですが、一例として、
    猫愛好家たちに有名な「ボニャール」と呼ばれるポーズを紹介します
    ピエール・ボナールの絵画、「白い猫」を由来としています
    """
  }
}

#Preview {
  SlidePreview {
    BonnardSlide()
  }
}

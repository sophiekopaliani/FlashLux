//
//  FrontCardView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import SwiftUI

struct FrontCardView: View {
  let card: DeckCard
  @State private var showTranslation = Bool.random()

  var body: some View {
    Text(displayText)
      .foregroundColor(.black)
      .font(.largeTitle)
      .fontWeight(.black)
      .card()
  }

  private var displayText: String {
    guard showTranslation else { return card.word }

    guard let translation = card.translation, translation.isEmpty else { return card.word }

    return translation
  }
}

//
//  BackCardView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import SwiftUI

struct BackCardView: View {
  let card: DeckCard

  var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 8) {
        wordHeader
        Text(card.partOfSpeech)
          .padding(.bottom)
      }
    }
    .card()
    .overlay(alignment: .bottomTrailing) {
      audioButton
    }
  }

  private var wordHeader: some View {
    HStack(alignment: .bottom) {
      Text(card.word)
        .font(.largeTitle)
      Text(card.translation ?? "")
    }
  }

  @ViewBuilder
  private var audioButton: some View {
    if let audioUrl = card.audioUrl, !audioUrl.isEmpty {
      AudioView(audioURL: audioUrl)
        .padding()
    }
  }
}

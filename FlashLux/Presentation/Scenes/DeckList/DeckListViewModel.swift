//
//  DeckListViewModel.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

@Observable class DeckViewModel {
  var deckToDisplay: [WordOverview] = []

  func loadDeck() {
    let storedDeck = DeckFileManager().getDeck()
    guard let storedDeck else { return }

    deckToDisplay = storedDeck.cards.map {
      WordOverview(id: $0.id, name: $0.word, partOfSpeech: $0.partOfSpeech)
    }
  }

  func removeFromDeck(_ cardId: String) {
    DeckFileManager().removeCard(id: cardId)
    loadDeck()
  }
}

struct WordOverview: Hashable, Identifiable {
  let id: String

  let name: String
  let partOfSpeech: String
}

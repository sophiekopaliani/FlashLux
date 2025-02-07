//
//  Deck.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

struct Deck: Codable {
  let id: String

  var name: String

  var cards: [DeckCard]

  init(id: String, name: String, cards: [DeckCard]) {
    self.id = id
    self.name = name
    self.cards = cards
  }

  init() {
    self.id = UUID().uuidString
    self.name = .init()
    self.cards = []
  }
}

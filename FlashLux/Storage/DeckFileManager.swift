//
//  DeckFileManager.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

final class DeckFileManager {
  static let defaultDeck: String = "defaultDeck.json"

  var fileManager = FileManagerHelper.shared

  func append(card: DeckCard, fileName: String = defaultDeck) {
    var deck = fileManager.loadData(fileName: fileName) as Deck? ?? Deck()
    guard !deck.cards.contains(card) else { return }
    deck.cards.append(card)
    fileManager.saveData(deck, fileName: fileName)
  }

  func removeCard(id: String, fileName: String = defaultDeck) {
    let deck = fileManager.loadData(fileName: fileName) as Deck?
    guard var deck else { return }
    deck.cards.removeAll { $0.id == id }
    fileManager.saveData(deck, fileName: fileName)
  }

  func getDeck(fileName: String = defaultDeck) -> Deck? {
    return fileManager.loadData(fileName: fileName) as Deck?
  }

  func save(deck: Deck, to fileName: String = defaultDeck) {
    fileManager.saveData(deck, fileName: fileName)
  }
}

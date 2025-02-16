//
//  FlashCardsViewViewModel.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation
import SwiftUI

@Observable
final class FlashCardsViewModel {

  private var deck: Deck? = nil
  var deckState: DeckState = .playing

  var cards = [DeckCard]()
  var flipped = false
  var rotation: CGFloat = 0

  enum DeckState {
    case loading, playing, submitting, finished
  }

  var topCard: DeckCard? {
    guard !cards.isEmpty else { return nil }
    return cards[cards.count-1]
  }

  init() {
    loadDeck()
  }

  func restartIfFinished() {
    guard deckState == .finished else { return }
    loadDeck()
  }

  func loadDeck() {
    let storedDeck = DeckFileManager().getDeck()
    guard let storedDeck else { return } //TODO: *S Refactor bottom
    //    deck = storedDeck
    cards = storedDeck.cards.shuffled()
    deckState = .playing
  }

  func nextCard() {
    LiyAnimation(duration: 1.0) {
      self.deckState = .playing
      self.cards.remove(at: self.cards.count-1)
      self.flipped = false
      self.rotation = 0.0
      self.checkForEndGame()
    }.playAfter(duration: 0.0)
  }

  func submitAnswer() {
    deckState = .submitting
    if flipped {
      nextCard()
    } else {
      flip()
    }
  }

  func flip() {
    let secondTurn = LiyAnimation(.spring, duration: 0.2, next: nil) {
      self.rotation += 90
    }

    let flipViews = LiyAnimation(.spring, duration: 0.01, next: secondTurn) {
      self.flipped = true
    }

    let firstTurn = LiyAnimation(.spring, duration: 0.2, next: flipViews) {
      self.rotation += 90
    }

    firstTurn.play()
  }

  func checkForEndGame() {
    if cards.isEmpty {
      deckState = .finished
    }
  }
}

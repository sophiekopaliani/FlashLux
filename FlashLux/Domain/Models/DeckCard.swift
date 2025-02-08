//
//  DeckCard.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

struct DeckCard { //TODO: *s rename it wrd details
  let id: String

  let word: String
  let transcription: String?

  let partOfSpeech: String //TODO: *S make an enum

  let translation: String?
  let translations: [String]


  let audioUrl: String?

  let randomOffset = Double.random(in: -10.0...10.0) //TODO: *s remove from here
}

extension DeckCard: Equatable {
  static func == (lhs: DeckCard, rhs: DeckCard) -> Bool {
    lhs.id == rhs.id
  }
}

extension DeckCard: Codable { }

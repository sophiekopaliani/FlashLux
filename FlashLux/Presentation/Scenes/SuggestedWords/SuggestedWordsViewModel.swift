//
//  SuggestedWordsViewModel.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

@Observable
final class SuggestedWordsViewModel {
  let word: String

  init(word: String) {
    self.word = word
  }

  var results: [SearchResult] = []

  func loadSuggestedWords() {
    request(with: word)
  }

  func request(with word: String) {
    Task {
      do {
        let suggestedWordsResult = try await DictionaryRepository().getSearchResults(for: word)
        results = suggestedWordsResult.results ?? []
      } catch {
        print(error)
      }
    }
  }
}

//
//  SuggestedWordsViewModel.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

@Observable final class SuggestedWordsViewModel {

  var results: [SearchResult] = []

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

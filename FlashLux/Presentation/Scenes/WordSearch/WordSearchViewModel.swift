//
//  WordSearchViewModel.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

@Observable final class WordSearchViewModel {
  var results: [SearchItem] = []

  func request(with input: String) {
    Task {
      do {
        let searchSuggessionsResponce = try await DictionaryRepository().getSuggestions(for: input)
        results = searchSuggessionsResponce.items
      } catch {
        print(error)
      }
    }
  }
}

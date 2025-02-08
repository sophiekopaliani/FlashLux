//
//  WordDetailsViewModel.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

@Observable final class WordDetailsViewModel {
  var wordDetails: DeckCard? = nil

  func request(with wordID: String) {
    Task {
      do {
        let wordDefinitionResponse = try await DictionaryRepository().getDefinition(for: wordID)
        wordDetails = DeckCard(from: wordDefinitionResponse.entry)
      } catch {
        print(error)
      }
    }
  }

  func addToDeck() {
    guard let wordDetails else { return }
    DeckFileManager().append(card: wordDetails)
  }
}

extension Entry { //TODO: *S move
  func getEnglishTranslations() -> [String] {
    microStructures.flatMap { microStructure in
      microStructure.grammaticalUnits?.flatMap { unit in
        unit.meanings.compactMap { meaning in
          meaning.targetLanguages["en"]?.parts.map(\.content)
        }.flatMap { $0 }
      } ?? []
    }
  }
}


extension DeckCard { //TODO: *S move
  init(from entry: Entry) {
    let translations = entry.getEnglishTranslations()
    self.init(
      id: entry.lodID,
      word: entry.lemma,
      transcription: entry.ipa,
      partOfSpeech: entry.partOfSpeech,
      translation: translations.first,
      translations: translations,
      audioUrl: entry.audioFiles.aac ?? entry.audioFiles.ogg
    )
  }
}

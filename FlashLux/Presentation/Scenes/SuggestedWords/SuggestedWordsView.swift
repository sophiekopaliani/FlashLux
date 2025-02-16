//
//  SuggestedWordsView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import SwiftUI

struct SuggestedWordsView: View {
  @State var viewModel: SuggestedWordsViewModel

  var body: some View {
    List(viewModel.results) { suggestion in
      wordRow(for: suggestion)
    }
    .task { viewModel.loadSuggestedWords() }
  }

  private func wordRow(for suggestion: SearchResult) -> some View {
    NavigationLink(destination: WordDetailsView(viewModel: .init(wordId: suggestion.id))) {
      VStack(alignment: .leading) {
        Text(suggestion.wordLb)
          .font(.title3)
          .fontWeight(.medium)
        Text(suggestion.pos)
      }
    }
  }
}

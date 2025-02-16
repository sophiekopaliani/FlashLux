//
//  SuggestedWordsView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import SwiftUI

struct SuggestedWordsView: View {
  @Environment(\.providerModeCoordinator) var coordinator
  @State var viewModel: SuggestedWordsViewModel

  var body: some View {
    List(viewModel.results) { suggestion in
      wordRow(for: suggestion)
    }
    .task { viewModel.loadSuggestedWords() }
  }

  private func wordRow(for suggestion: SearchResult) -> some View {
    Button {
      coordinator.searchRoute.navigate(
        to: .wordDetails(suggestion.id)
      )
    } label: {
      VStack(alignment: .leading) {
        Text(suggestion.wordLb)
          .font(.title3)
          .fontWeight(.medium)
          .foregroundStyle(.black)
        Text(suggestion.pos)
      }
    }
  }
}

//
//  DeckListView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import SwiftUI

struct DeckView: View { //TODO: *S rename to DeckListView
  @State private var viewModel = DeckViewModel()

  var body: some View {
    NavigationStack {
      deckList
        .task { viewModel.loadDeck() }
    }
  }

  private var deckList: some View {
    List(viewModel.deckToDisplay) { word in
      wordRow(for: word)
    }
  }

  private func wordRow(for word: WordOverview) -> some View {
    NavigationLink(destination: WordDetailsView(wordId: word.id)) {
      Text(word.name)
    }
    .swipeActions(edge: .trailing) {
      deleteButton(for: word.id)
    }
  }

  private func deleteButton(for id: String) -> some View {
    Button(role: .destructive) {
      viewModel.removeFromDeck(id)
    } label: {
      Label("Delete", systemImage: "trash")
    }
  }
}


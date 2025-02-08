//
//  WordSearchView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//


import SwiftUI

struct WordSearchView: View {
  @State public var viewModel: WordSearchViewModel
  @State private var searchTerm: String = ""

  var body: some View {
    NavigationStack {
      searchResults
        .listStyle(.plain)
        .navigationTitle("Search")
        .searchable(
          text: $searchTerm,
          placement: .automatic,
          prompt: "Enter search word here"
        )
        .task(id: searchTerm) {
          viewModel.request(with: searchTerm)
        }
    }
  }

  private var searchResults: some View {
    List(viewModel.results, id: \.word) { word in
      NavigationLink(
        destination: SuggestedWordsView(
          word: word.word,
          viewModel: SuggestedWordsViewModel()
        )
      ) {
        Text(word.word)
          .font(.title3)
          .fontWeight(.medium)
      }
    }
  }
}

#Preview {
  ContentView()
}

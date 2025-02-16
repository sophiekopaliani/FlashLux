//
//  WordSearchView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//


import SwiftUI

struct WordSearchView: View {
  @Environment(\.providerModeCoordinator) var coordinator

  @State  var viewModel: WordSearchViewModel
  @State private var searchTerm: String = ""

  var body: some View {
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

  private var searchResults: some View {
    List(viewModel.results, id: \.word) { word in
      Button {
        coordinator.searchRoute.navigate(
          to: .suggestedWords(word.word)
        )
      } label: {
        Text(word.word)
          .font(.title3)
          .fontWeight(.medium)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}

#Preview {
  ContentView()
}

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

  @FocusState private var isSearchFocused: Bool

  var body: some View {
    if #available(iOS 18.0, *) {
      searchResults
        .listStyle(.plain)
        .navigationTitle("Search")
        .searchable(
          text: $searchTerm,
          placement: .automatic,
          prompt: "Enter search word here"
        )
        .searchFocused($isSearchFocused)
        .onAppear {
          isSearchFocused = true
          searchTerm = ""
        }
        .task(id: searchTerm) {
          viewModel.request(with: searchTerm)
        }
    } else { //Withous search focus remove it afte upgrading
      searchResults
        .listStyle(.plain)
        .navigationTitle("Search")
        .searchable(
          text: $searchTerm,
          placement: .automatic,
          prompt: "Enter search word here"
        )
        .onAppear {
          isSearchFocused = true
          searchTerm = ""
        }
        .task(id: searchTerm) {
          viewModel.request(with: searchTerm)
        }
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

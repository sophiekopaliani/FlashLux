//
//  WordDetailsView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import SwiftUI

struct WordDetailsView: View {
  @Environment(\.providerModeCoordinator) private var coordinator
  @State var viewModel: WordDetailsViewModel

  var body: some View {
    Group {
      if let details = viewModel.wordDetails {
        wordContent(details)
      } else {
        ProgressView()
      }
    }
    .task { viewModel.loadDetails() }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          coordinator.searchRoute.popToRoot()
        } label: {
          Image(systemName: "magnifyingglass")
        }
      }
    }
  }

  private func wordContent(_ details: DeckCard) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      wordHeader(details)
      definitionSection(details)
    }
    .padding()
  }

  private func wordHeader(_ details: DeckCard) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(alignment: .bottom) {
        Text(details.word).font(.largeTitle)
        copy(word: details.word)
        addButton
        Text(details.transcription ?? "")
      }
      Text(details.partOfSpeech)
    }
  }

  @ViewBuilder
  private func copy(word: String) -> some View {
    Button {
      UIPasteboard.general.string = word
    } label: {
      Image(systemName: "doc.on.doc")
        .font(.system(size: 16))
    }
  }

  @ViewBuilder
  private var addButton: some View {
    Button("add") { viewModel.addToDeck() }
  }

  @ViewBuilder
  private func definitionSection(_ details: DeckCard) -> some View {
    ScrollView {
      VStack(alignment: .leading) {
        definitionHeader(details)
        ForEach(details.translations, id: \.self) {
          Text($0)
        }
      }
    }
    .scrollDisabled(details.translations.count < 15)
  }

  @ViewBuilder
  private func definitionHeader(_ details: DeckCard) -> some View {
    HStack {
      Text("Definition:")
        .font(.title2)
      Spacer()
      if let url = details.audioUrl { //TODO: *S
        AudioView(audioURL: url)
      }
    }
  }

  @ViewBuilder
  private var translationsList: some View {
    LazyVStack(alignment: .leading) {
      ForEach(viewModel.wordDetails?.translations ?? [], id: \.self) { translation in
        Text(translation)
      }
    }
  }
}

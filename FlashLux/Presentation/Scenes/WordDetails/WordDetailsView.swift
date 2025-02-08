//
//  WordDetailsView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import SwiftUI

struct WordDetailsView: View {
  let wordId: String
  @State private var viewModel = WordDetailsViewModel()

  var body: some View {
    Group {
      if let details = viewModel.wordDetails {
        wordContent(details)
      } else {
        ProgressView()
      }
    }
    .task { viewModel.request(with: wordId) }
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
        addButton
        Text(details.transcription ?? "")
      }
      Text(details.partOfSpeech)
    }
  }

  private var addButton: some View {
    Button("add") { viewModel.addToDeck() }
  }

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

  private var translationsList: some View {
    LazyVStack(alignment: .leading) {
      ForEach(viewModel.wordDetails?.translations ?? [], id: \.self) { translation in
        Text(translation)
      }
    }
  }
}

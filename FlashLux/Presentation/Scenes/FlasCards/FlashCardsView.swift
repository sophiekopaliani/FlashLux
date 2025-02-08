//
//  FlashCardsView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import SwiftUI

struct FlashCardsView: View {
  @State var viewModel: FlashCardsViewModel

  var body: some View {
    VStack {
      ZStack {
        cardPile
          .onTapGesture {
            viewModel.submitAnswer()
          }
      }
      endScreen
    }
    .navigationTitle("Saved")
    .navigationBarTitleDisplayMode(.large)
    .onAppear { //TODO: *S on appear or task?
      viewModel.restartIfFinished()
    }
  }
}

extension FlashCardsView {
  private var cardPile: some View {
    ZStack {
      ForEach(viewModel.cards, id: \.id) { card in
        flashCard(card: card, isTopCard: card == viewModel.cards.last)
      }
    }
  }

  private func flashCard(card: DeckCard, isTopCard: Bool) -> some View {
    cardSides(card: card, isTopCard: isTopCard)
      .transition(.slide)
      .zIndex(isTopCard ? 999 : 0)
      .allowsHitTesting(isTopCard ? true : false)
      .offset(x: isTopCard ? 0 : card.randomOffset, y: isTopCard ? 0 : card.randomOffset)
      .rotationEffect(.degrees(isTopCard ? 0 : card.randomOffset))
  }

  private func cardSides(card: DeckCard, isTopCard: Bool) -> some View {
    ZStack {
      FrontCardView(card: card)
        .rotation3DEffect(.degrees(isTopCard ? viewModel.rotation : 0), axis: (x: 0, y: 1, z: 0))
        .opacity(isTopCard ? viewModel.flipped ? 0 : 1 : 1)
      BackCardView(card: card)
        .rotation3DEffect(.degrees(isTopCard ? viewModel.rotation + 180 : 0), axis: (x: 0, y: 1, z: 0))
        .opacity(isTopCard ? viewModel.flipped ? 1 : 0 : 0)
    }
  }

  @ViewBuilder
  private var endScreen: some View {
    if viewModel.deckState == .finished {
      VStack {
        Text("All Done")
        Button {
          viewModel.loadDeck()
        } label: {
          Text("reload")
            .padding()
            .background(.ultraThickMaterial)
            .cornerRadius(7)
        }
      }
    }
  }
}

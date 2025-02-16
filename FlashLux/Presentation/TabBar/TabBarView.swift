//
//  TabBarView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import SwiftUI

enum ProviderViewModeTabItem: Int, CaseIterable {
  case search = 1
  case learn
  case saved

  var title: String {
    switch self {
    case .search: "Search"
    case .learn: "Learn"
    case .saved: "Saved"
    }
  }

  var icon: Image {
    .init(systemName: "square.and.arrow.up")
  }
}

struct TabBarView: View {
  @Environment(\.providerModeCoordinator) var coordinator

  private var flashCardsVM = FlashCardsViewModel()

  @State var selectedTab: ProviderViewModeTabItem = .search

  var body: some View {
    ZStack(alignment: .bottom) {
      getTabViewContent()

      getTabBar()
    }
    .edgesIgnoringSafeArea(.bottom)
  }

  private func getTabViewContent() -> some View {
    TabView(selection: $selectedTab) {
      wordSearchBaseView()
        .tag(ProviderViewModeTabItem.search)

      flasCardsView()
        .tag(ProviderViewModeTabItem.learn)

      deckListView()
        .tag(ProviderViewModeTabItem.saved)
    }
    .sensoryFeedback(.selection, trigger: selectedTab)
  }

  @ViewBuilder
  func wordSearchBaseView() -> some View {
    @Bindable var coordinator = coordinator

    NavigationStack(path: $coordinator.searchRoute.path) {
      WordSearchView(viewModel: WordSearchViewModel())
        .navigationDestination(for: SearchRoute.self) { selection in
          switch selection {
          case .wordSearch:
            WordSearchView(viewModel: WordSearchViewModel())
          case .suggestedWords(let word):
            let vm = SuggestedWordsViewModel(word: word)
            SuggestedWordsView(viewModel: vm)
          case .wordDetails(let wordID):
            let vm = WordDetailsViewModel(wordId: wordID)
            WordDetailsView(viewModel: vm)
          }
        }
    }
  }

  @ViewBuilder
  func flasCardsView() -> some View {
    @Bindable var coordinator = coordinator

    NavigationStack(path: $coordinator.learnRoute.path) {
      FlashCardsView(viewModel: flashCardsVM)
        .navigationDestination(for: LearnRoute.self) { selection in
          switch selection {
          case .flashCards:
            FlashCardsView(viewModel: flashCardsVM)
          }
        }
    }
  }

  @ViewBuilder
  func deckListView() -> some View {
    @Bindable var coordinator = coordinator

    NavigationStack(path: $coordinator.deckRoute.path) {
      DeckListView()
        .navigationDestination(for: DeckRoute.self) { selection in
          switch selection {
          case .DeckList:
            DeckListView()
          case .WordDetails(let wordID):
            let vm = WordDetailsViewModel(wordId: wordID)
            WordDetailsView(viewModel: vm)
          }
        }
    }
  }

  @ViewBuilder
  private func getTabBar() -> some View {
    ZStack {
      VStack(spacing: .zero) {
        HStack {
          ForEach(ProviderViewModeTabItem.allCases, id: \.self) { item in
            getTabBarButton(for: item)
          }
        }
        .padding(.horizontal, 10.0)
        .padding(.top, 4.0)
        .background(Color.white)
      }
    }
    .frame(height: 54.0)
    .safeAreaPadding(.bottom, 30.0)
    .background(
      Color.white.ignoresSafeArea()
    )
    .clipShape(
      .rect(
        topLeadingRadius: 30,
        bottomLeadingRadius: 0,
        bottomTrailingRadius: 0,
        topTrailingRadius: 30
      )
    )
    .shadow(color: .black.opacity(0.04), radius: 7.5, x: 0, y: -13)
    .transition(.move(edge: .bottom))
  }

  private func getTabBarButton(for item: ProviderViewModeTabItem) -> some View {
    Button {
      selectedTab = item
    } label: {
      HStack {
        Spacer()
        VStack(spacing: 7.0) {
          item.icon
            .resizable()
            .scaledToFit()
            .frame(width: 18, height: 18)
          Text(item.title)
            .font(.system(size: 11, weight: .bold))
        }
        Spacer()
      }
      .foregroundStyle(selectedTab == item ? .black : .red)
    }
    .id(item)
  }
}

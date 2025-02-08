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
      WordSearchView(viewModel: WordSearchViewModel()) //TODO: *S
        .tag(ProviderViewModeTabItem.search)

      FlashCardsView(viewModel: flashCardsVM)
        .tag(ProviderViewModeTabItem.learn)

      DeckView()
        .tag(ProviderViewModeTabItem.saved)
    }
    .sensoryFeedback(.selection, trigger: selectedTab)
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

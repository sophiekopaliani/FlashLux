//
//  ContentView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabBarView(selectedTab: .search)
      .edgesIgnoringSafeArea(.bottom)
  }
}

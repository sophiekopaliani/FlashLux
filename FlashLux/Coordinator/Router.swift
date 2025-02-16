//
//  Coordinator.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 16.02.25.
//

import SwiftUI

@Observable
final class Coordinator {
  var searchRoute = Router<SearchRoute>(path: [])
  var learnRoute = Router<LearnRoute>(path: [])
  var deckRoute = Router<DeckRoute>(path: [])
}

private struct CoordinatorKey: EnvironmentKey {
  static var defaultValue: Coordinator = .init()
}

extension EnvironmentValues {
  var providerModeCoordinator: Coordinator {
    get { self[CoordinatorKey.self] }
    set { self[CoordinatorKey.self] = newValue }
  }
}


@Observable
class Router<Route: RouteType> {
  var path: [Route] = []
  var rootNeedsUpdate: Bool = false

  init(path: [Route]) {
    self.path = path
  }

  func navigate(to route: Route) {
    path.append(route)
  }

  func goBack() {
    if !path.isEmpty {
      path.removeLast()
    }
  }

  func popToRoot() {
    path.removeAll()
  }
}

protocol RouteType: Hashable { }

//
//  DictionatyService.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

enum DictionatyService {
  case suggession(word: String)
  case definition(wordID: String)
  case search(word: String)
}

extension DictionatyService: Endpoint {
  var path: String {
    switch self {
    case .suggession: "/api/lb/suggest"
    case .definition(let wordID): "/api/lb/entry/\(wordID)"
    case .search: "/api/lb/search"
    }
  }

  var method: RequestMethod {
    switch self {
    case .suggession, .definition, .search:
      return .get
    }
  }

  var header: [String: String]? {
    switch self {
    case .suggession, .definition, .search:
      return nil
    }
  }

  var body: [String: String]? {
    switch self {
    case .suggession, .definition, .search:
      return nil
    }
  }

  var queryItems: [URLQueryItem] {
    switch self {
    case .suggession(let word):
      var queryParameters: [URLQueryItem] = []
      queryParameters.append(.init(name: "lang", value: "lb"))
      queryParameters.append(.init(name: "query", value: word))
      return queryParameters
    case .definition: return []
    case .search(let word):
      var queryParameters: [URLQueryItem] = []
      queryParameters.append(.init(name: "lang", value: "lb"))
      queryParameters.append(.init(name: "query", value: word))
      return queryParameters
    }
  }
}

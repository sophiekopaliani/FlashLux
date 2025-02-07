//
//  SearchResponse.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

public struct SearchResponse {
  public let query: String
  public let items: [SearchItem]

  public init(
    query: String,
    items: [SearchItem] = []
  ) {
    self.query = query
    self.items = items
  }
}

extension SearchResponse: Codable { }
extension SearchResponse: Equatable { }
extension SearchResponse: Hashable { }
extension SearchResponse: Sendable { }

public struct SearchItem {
  public let word: String
  public let lang: String
  public let type: String

  public init(
    word: String,
    lang: String,
    type: String
  ) {
    self.word = word
    self.lang = lang
    self.type = type
  }
}

extension SearchItem: Codable { }
extension SearchItem: Equatable { }
extension SearchItem: Hashable { }
extension SearchItem: Sendable { }

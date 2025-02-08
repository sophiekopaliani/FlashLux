//
//  SearchResultsResponse.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

public struct SearchResultsResponse {
  public let description: String
  public let results: [SearchResult]?

  public init(
    description: String,
    results: [SearchResult] = []
  ) {
    self.description = description
    self.results = results
  }
}

extension SearchResultsResponse: Codable { }
extension SearchResultsResponse: Equatable { }
extension SearchResultsResponse: Hashable { }
extension SearchResultsResponse: Sendable { }

public struct SearchResult {
  public let id: String
  public let articleId: String
  public let wordLb: String
  public let scientificName: String
  public let pos: String
  public let erroneous: Bool
  public let signLanguage: Bool
  public let matches: [String]?

  public init(
    id: String,
    articleId: String,
    wordLb: String,
    scientificName: String,
    pos: String,
    erroneous: Bool,
    signLanguage: Bool,
    matches: [String] = []
  ) {
    self.id = id
    self.articleId = articleId
    self.wordLb = wordLb
    self.scientificName = scientificName
    self.pos = pos
    self.erroneous = erroneous
    self.signLanguage = signLanguage
    self.matches = matches
  }
}

extension SearchResult: Codable {
  enum CodingKeys: String, CodingKey {
    case id
    case articleId = "article_id"
    case wordLb = "word_lb"
    case scientificName = "scientific_name"
    case pos
    case erroneous
    case signLanguage = "sign_language"
    case matches
  }
}
extension SearchResult: Equatable { }
extension SearchResult: Hashable { }
extension SearchResult: Sendable { }
extension SearchResult: Identifiable {
  public static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
    lhs.id == rhs.id
  }
}

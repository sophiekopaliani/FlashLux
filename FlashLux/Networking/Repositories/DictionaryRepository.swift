//
//  DictionaryRepository.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

protocol DictionaryRepositoring {
  func getSuggestions(for word: String) async throws -> SearchResponse
  func getDefinition(for wordID: String) async throws -> DictionaryEntryResponse
  func getSearchResults(for input: String) async throws -> SearchResultsResponse
}

struct DictionaryRepository: DictionaryRepositoring {
  var dataTransport = DataTranspoprt()

  func getSuggestions(for input: String) async throws -> SearchResponse {
    let request = try DictionatyService.suggession(word: input).asURLRequest()
    return try await dataTransport.sendRequest(type: SearchResponse.self, with: request)
  }

  func getDefinition(for wordID: String) async throws -> DictionaryEntryResponse {
    let request = try DictionatyService.definition(wordID: wordID).asURLRequest()
    return try await dataTransport.sendRequest(type: DictionaryEntryResponse.self, with: request)
  }

  func getSearchResults(for input: String) async throws -> SearchResultsResponse {
    let request = try DictionatyService.search(word: input).asURLRequest()
    return try await dataTransport.sendRequest(type: SearchResultsResponse.self, with: request)
  }
}

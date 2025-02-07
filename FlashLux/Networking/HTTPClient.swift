//
//  HTTPClient.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//


import Foundation

protocol HTTPClient {
  var session: URLSession { get }
  func sendRequest<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T
}

extension HTTPClient {
  func sendRequest<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
    let (data, response) = try await session.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw NetworkError.requestFailed("Invalid response")
    }

    guard httpResponse.statusCode == 200 else {
      throw NetworkError.serverError(statusCode: httpResponse.statusCode)
    }

    do {
      let decoder = JSONDecoder()
      return try decoder.decode(type, from: data)
    } catch let decodingError as DecodingError {
      throw NetworkError.decodingError(decodingError)
    } catch {
      throw NetworkError.unknown(error)
    }
  }
}

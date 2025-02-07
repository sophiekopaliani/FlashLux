//
//  NetworkError.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
  case invalidURL
  case decodingError(DecodingError)
  case serverError(statusCode: Int)
  case pathEncodingFailed(String)
  case malformedQueryParameters([URLQueryItem])
  case unknown(Error)
  case requestFailed(String)

  var errorDescription: String? {
    switch self {
    case .invalidURL: "Invalid URL configuration"
    case .decodingError(let error): "Decoding Error \(error)"
    case .serverError(let statusCode): "server failed with code \(statusCode)"
    case .pathEncodingFailed(let path):  "Failed to encode path component: \(path)"
    case .malformedQueryParameters(let items): "Invalid query items: \(items)"
    case .requestFailed(let description): "Request Failed: \(description)"
    default: "Error"
    }
  }
}

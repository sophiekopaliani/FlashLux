//
//  Endpoint.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

protocol Endpoint {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var method: RequestMethod { get }
  var header: [String: String]? { get }
  var queryItems: [URLQueryItem] { get }
  var body: [String: String]? { get }
}

extension Endpoint {
  var scheme: String {
    return APIConfig.scheme
  }

  var host: String {
    return APIConfig.host
  }
}

extension Endpoint {
  var urlConponents: URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = scheme
    urlComponents.host = host
    urlComponents.path = path
    urlComponents.queryItems = queryItems
    return urlComponents
  }

  func asURLRequest() throws -> URLRequest {
    guard let url = urlConponents.url else {
      throw NetworkError.invalidURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue

    if let header = header {
      request.allHTTPHeaderFields = header
    }

    if let body = body {
      request.httpBody = try? JSONSerialization.data(withJSONObject: body)

      if request.value(forHTTPHeaderField: "Content-Type") == nil {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      }
    }

    return request
  }
}

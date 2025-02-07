//
//  NetworkingManager.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

final class DataTranspoprt: HTTPClient {

  let session: URLSession

  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }

  convenience init() {
    self.init(configuration: .default)
  }
}

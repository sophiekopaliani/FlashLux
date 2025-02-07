//
//  FileManagerHelper.swift
//  FLashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import Foundation

final class FileManagerHelper {
  static let shared = FileManagerHelper()

  private let fileManager = FileManager.default

  private func getDocumentsDirectory() -> URL {
    fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }

  func saveData<T: Codable>(_ data: T, fileName: String) {
    let url = getDocumentsDirectory().appendingPathComponent(fileName)
    if !fileManager.fileExists(atPath: url.path) {
      try? fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    }
    do {
      let encodedData = try JSONEncoder().encode(data)
      try encodedData.write(to: url)
    } catch {
      print("Error saving data: \(error)")
    }
  }

  func loadData<T: Codable>(fileName: String) -> T? {
    let url = getDocumentsDirectory().appendingPathComponent(fileName)
    do {
      let data = try Data(contentsOf: url)
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      print("Error loading data: \(error)")
      return nil
    }
  }
}

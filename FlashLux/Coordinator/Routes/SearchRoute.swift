//
//  SearchRoute.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 16.02.25.
//

enum SearchRoute: RouteType {
  case wordSearch
  case wordDetails(String)
  case suggestedWords(String)
}

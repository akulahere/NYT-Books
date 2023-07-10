//
//  CategoryResponse.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import Foundation

struct CategoriesResponse: Codable {
  let status: String
  let copyright: String
  let numResults: Int
  let results: [Category]

  private enum CodingKeys: String, CodingKey {
    case status
    case copyright
    case numResults = "num_results"
    case results
  }
}

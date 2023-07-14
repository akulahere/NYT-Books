//
//  BookListResponse.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import Foundation

struct BooksListResponse: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let lastModified: String
    let results: BooksList

    private enum CodingKeys: String, CodingKey {
      case status
      case copyright
      case numResults = "num_results"
      case lastModified = "last_modified"
      case results
    }
}

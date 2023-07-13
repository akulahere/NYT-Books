//
//  BookList.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import Foundation

struct BooksList: Codable {
    let listName: String
    let listNameEncoded: String
    let bestsellersDate: String
    let publishedDate: String
    let publishedDateDescription: String
    let nextPublishedDate: String
    let previousPublishedDate: String
    let displayName: String
    let normalListEndsAt: Int
    let updated: String
    let books: [Book]
    let corrections: [String]

    private enum CodingKeys: String, CodingKey {
      case listName = "list_name"
      case listNameEncoded = "list_name_encoded"
      case bestsellersDate = "bestsellers_date"
      case publishedDate = "published_date"
      case publishedDateDescription = "published_date_description"
      case nextPublishedDate = "next_published_date"
      case previousPublishedDate = "previous_published_date"
      case displayName = "display_name"
      case normalListEndsAt = "normal_list_ends_at"
      case updated
      case books
      case corrections
    }
}

//
//  Book.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import Foundation

struct Book: Codable {
  let rank: Int
  let rankLastWeek: Int
  let weeksOnList: Int
  let asterisk: Int
  let dagger: Int
  let primaryIsbn10: Date
  let primaryIsbn13: Date
  let publisher: String
  let description: String
  let price: String
  let title: String
  let author: String
  let contributor: String
  let contributorNote: String
  let bookImage: URL
  let bookImageWidth: Int
  let bookImageHeight: Int
  let amazonProductURL: URL
  let ageGroup: String
  let bookReviewLink: String
  let firstChapterLink: String
  let sundayReviewLink: String
  let articleChapterLink: String
  let isbns: [Isbn]
  let buyLinks: [BuyLink]
  let bookUri: URL

  private enum CodingKeys: String, CodingKey {
    case rank
    case rankLastWeek = "rank_last_week"
    case weeksOnList = "weeks_on_list"
    case asterisk
    case dagger
    case primaryIsbn10 = "primary_isbn10"
    case primaryIsbn13 = "primary_isbn13"
    case publisher
    case description
    case price
    case title
    case author
    case contributor
    case contributorNote = "contributor_note"
    case bookImage = "book_image"
    case bookImageWidth = "book_image_width"
    case bookImageHeight = "book_image_height"
    case amazonProductURL = "amazon_product_url"
    case ageGroup = "age_group"
    case bookReviewLink = "book_review_link"
    case firstChapterLink = "first_chapter_link"
    case sundayReviewLink = "sunday_review_link"
    case articleChapterLink = "article_chapter_link"
    case isbns
    case buyLinks = "buy_links"
    case bookUri = "book_uri"
  }
}

struct Isbn: Codable {
  let isbn10: String
  let isbn13: String
}

struct BuyLink: Codable {
  let name: String
  let url: URL
}

//
//  Book.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import Foundation

struct Book: Codable {
    let rank: Int
    let publisher: String
    let description: String
    //    let price: String
    let title: String
    let author: String
    let bookImage: URL
    let buyLinks: [BuyLink]
    
    init(realmBook: RealmBook) {
        self.title = realmBook.title
        self.author = realmBook.author
        self.bookImage = URL(string: realmBook.bookImage)!
        self.description = realmBook.bookDescription
        self.publisher = realmBook.publisher
        self.rank = realmBook.rank
        self.buyLinks = []
        
        
    }
    private enum CodingKeys: String, CodingKey {
        case rank
        case publisher
        case description
        case title
        case author
        case bookImage = "book_image"
        case buyLinks = "buy_links"
    }
}

struct BuyLink: Codable {
    let name: String
    let url: URL
}

//
//  BookViewModel.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import UIKit

class BookCellViewModel {
    let book: Book
    let networkService: NetworkService

    init(book: Book, networkService: NetworkService) {
        self.book = book
        self.networkService = networkService
    }
    
    func bookImage() async throws -> UIImage {
        let url = book.bookImage
        return try await networkService.fetchImage(from: url)
    }
    
    func bookDescription() -> String {
        return book.description
    }
    
    func bookAuthor() -> String {
        return book.author
    }
    
    func bookPublisher() -> String {
        return book.publisher
    }
    
    func bookRank() -> String {
        let rank = String(book.rank)
        return rank
    }
    
    func bookBuyLink() -> URL? {
        return book.buyLinks.first?.url
    }
}


// book's name, description, author, publisher, image, and rank. Additionally, there should be a link to buy this book.

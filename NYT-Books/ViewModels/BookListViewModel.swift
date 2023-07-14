//
//  BookListViewModel.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import Foundation

protocol BooksListViewModelDelegate: BookListViewController {
    func didUpdateBooks()
    func didFailWithError(error: Error)
}

class BookListViewModel {
    var books: [Book] = []
    var categoryName: String
    let networkService: NetworkServiceProtocol
    let cacheManager: CacheManager = .shared
    weak var delegate: BooksListViewModelDelegate?
    
    init(networkService: NetworkServiceProtocol, categoryName: String)  {
        self.categoryName = categoryName
        self.networkService = networkService
    }
    
    public func getBooks() async {
        do {
            let bookListResponse = try await networkService.fetchBooks(name: self.categoryName)
            self.books = bookListResponse.results.books
            await cacheManager.saveBooks(self.books, forCategory: categoryName)
            await delegate?.didUpdateBooks()
        } catch {
            let cachedBooks = await cacheManager.getBooks(forCategory: self.categoryName)
            if !cachedBooks.isEmpty {
                self.books = cachedBooks
                await delegate?.didUpdateBooks()
                return
            }
            await delegate?.didFailWithError(error: error)
        }
    }
}

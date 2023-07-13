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
    let networkService: NetworkService
    weak var delegate: BooksListViewModelDelegate?
    
    init(networkService: NetworkService, categoryName: String)  {
        self.categoryName = categoryName
        self.networkService = networkService
    }
    
    public func getBooks() async {
        do {
            let bookListResponse = try await networkService.fetchCustomCategory(name: self.categoryName)
            self.books = bookListResponse.results.books
            print(books)
            await delegate?.didUpdateBooks()
        } catch {
            await delegate?.didFailWithError(error: error)
        }
    }
}

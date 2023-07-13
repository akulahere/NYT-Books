//
//  BookListViewModel.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import Foundation

class BookListViewModel {
    var books: [Book] = []
    let networkService: NetworkService
    weak var delegate: CategoriesViewModelDelegate?
    
    init(networkService: NetworkService = NetworkService())  {
        self.networkService = networkService
    }
    

}

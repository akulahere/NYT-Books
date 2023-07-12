//
//  CategoriesViewModel.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import Foundation

protocol CategoriesViewModelDelegate: CategoriesViewController {
    func didUpdateCategories()
    func didFailWithError(error: Error)
}

class CategoriesViewModel {
    var categories: [Category] = []
    let networkService: NetworkService
    weak var delegate: CategoriesViewModelDelegate?
    
    init(networkService: NetworkService = NetworkService())  {
        self.networkService = networkService
    }
    
    public func getCategories() async {
        do {
            let categoriesResponse = try await networkService.fetchCategories()
            self.categories = categoriesResponse.results
            print(categories)
            await delegate?.didUpdateCategories()
        } catch {
            await delegate?.didFailWithError(error: error)
        }
    }
}

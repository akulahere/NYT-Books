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
    let cacheManager: CacheManager = .shared
    let networkService: NetworkServiceProtocol
    weak var delegate: CategoriesViewModelDelegate?
    
    init(networkService: NetworkService = NetworkService())  {
        self.networkService = networkService
    }
    
    public func getCategories() async {
        do {
            let categoriesResponse = try await networkService.fetchCategories()
            self.categories = categoriesResponse.results
            cacheManager.saveCategories(self.categories)
            await delegate?.didUpdateCategories()
        } catch NetworkServiceError.serverError {
            self.categories = cacheManager.getCategories()
            await delegate?.didUpdateCategories()
        } catch {
            await delegate?.didFailWithError(error: error)
        }
    }
}

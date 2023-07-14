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
    
    init(networkService: NetworkServiceProtocol)  {
        self.networkService = networkService
    }
    
    public func getCategories() async {
        do {
            let categoriesResponse = try await networkService.fetchCategories()
            self.categories = categoriesResponse.results
            cacheManager.saveCategories(self.categories)
            await delegate?.didUpdateCategories()
        } catch {
            let cachedCategories = cacheManager.getCategories()
            if !cachedCategories.isEmpty {
                self.categories = cachedCategories
                await delegate?.didUpdateCategories()
                return
            }
            await delegate?.didFailWithError(error: error)
        }
    }
}

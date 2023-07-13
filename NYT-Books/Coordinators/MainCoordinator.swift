//
//  MainCoordinator.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Variables
    
    private let navigationController: UINavigationController
    private let netWorkService: NetworkService

    // MARK: -
    // MARK: Initialisators
    
    init(navigationController: UINavigationController, networkService: NetworkService) {
        self.navigationController = navigationController
        self.netWorkService = networkService
    }
    
    func start() {
        let categoriesVM = CategoriesViewModel(networkService: self.netWorkService)
        let categoriesVC = CategoriesViewController(viewModel: categoriesVM)
        let handler: EventHandler = {[weak self] event in
            switch event {
                case .displayBookList(let categoryName):
                    self?.displayBookList(name: categoryName)
            }
            
        }
        
        categoriesVC.eventHandler = handler
        self.navigationController.pushViewController(categoriesVC, animated: false)
    }
    
    func displayBookList(name: String) {
        let bookListVM = BookListViewModel(networkService: self.netWorkService, categoryName: name)
        let bookListVC = BookListViewController(viewModel: bookListVM)
        print("BOOK LIST")
        navigationController.pushViewController(bookListVC, animated: true)
    }
}

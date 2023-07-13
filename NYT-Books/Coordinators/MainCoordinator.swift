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
    
    init(navigationController: UINavigationController, networkService: NetworkService)    {
        self.navigationController = navigationController
        self.netWorkService = networkService
    }
    
    func start() {
        let vm = CategoriesViewModel()
        let vc = CategoriesViewController(viewModel: vm)
        let handler: EventHandler = { [weak self] event in
            switch event {
                case .displayBookList(let categoryName):
                    self?.displayBookList(name: categoryName)
            }
            
        }
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    func displayBookList(name: String) {
        let bookListVM = BookListViewModel()
        let bookListVC = BookListViewController(categoryName: name)
        navigationController.pushViewController(bookListVC, animated: true)
    }
}

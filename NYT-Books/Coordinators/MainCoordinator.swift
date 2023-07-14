//
//  MainCoordinator.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import UIKit

class MainCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let netWorkService: NetworkServiceProtocol
    
    init(navigationController: UINavigationController, networkService: NetworkServiceProtocol) {
        self.navigationController = navigationController
        self.netWorkService = networkService
        
    }
    
    func start() {
        let viewModel = CategoriesViewModel(networkService: self.netWorkService)
        let viewController = CategoriesViewController(viewModel: viewModel)
        let handler: EventHandler<CategoriesViewControllerEvent> = { [weak self] event in
            switch event {
                case .displayBookList(let categoryName):
                    self?.displayBookList(name: categoryName)
            }
        }
        
        viewController.eventHandler = handler
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func displayBookList(name: String) {
        let viewModel = BookListViewModel(networkService: self.netWorkService, categoryName: name)
        let viewController = BookListViewController(viewModel: viewModel)
        let handler: EventHandler<BookListViewControllerEvent> = { [weak self] event in
            switch event {
                case .displayWebPage(let url):
                    self?.displayWebPage(url: url)
            }
            
        }
        viewController.eventHandler = handler
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func displayWebPage(url: URL) {
        let viewController = WebViewController(url: url)
        navigationController.pushViewController(viewController, animated: true)
    }
}

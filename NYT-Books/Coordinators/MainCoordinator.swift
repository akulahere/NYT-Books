//
//  MainCoordinator.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import Foundation

class MainCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Variables
    
    private let navigationController: UINavigationController

    
    
    // MARK: -
    // MARK: Initialisators
    
    init(navigationController: UINavigationController)    {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController()
//        let handler: EventHandler = { [weak self] event in
//            switch event {
//                case .displayForecast(let forecast):
//                    self?.showDetailForecast(forecast: forecast)
//            }
//        }
//
//        vc.eventsHandler = handler
        self.navigationController.pushViewController(vc, animated: false)
    }
    
//    func showDetailForecast(forecast: Forecast) {
//        let detailForecastVC = DetailedForecastViewController(forecast: forecast, apiService: self.apiService)
//        navigationController.pushViewController(detailForecastVC, animated: true)
//    }
}

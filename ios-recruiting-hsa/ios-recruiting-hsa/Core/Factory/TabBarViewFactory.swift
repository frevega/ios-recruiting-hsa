//
//  TabBarViewFactory.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class TabBarViewFactory {
    private let serviceLocator: ServiceLocator
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
    
    func viewController() -> UITabBarController {
        let gridController = gridViewController()
        let gridCoordinator = GridCoordinatorImpl(
            viewController: gridController,
            navigationController: UINavigationController()
        )
        
        let favoriteController = favoriteViewController()
        let favoriteCoordinator = FavoriteCoordinatorImpl(
            viewController: favoriteController,
            navigationController: UINavigationController()
        )
        
        let viewController = TabBarViewController(
            gridCoordinator: gridCoordinator,
            favoriteCoordinator: favoriteCoordinator
        )
        
        return viewController
    }
    
    private func gridViewController() -> UIViewController {
        let presenter = serviceLocator.gridPresenter
        let delegate = GridViewDelegate()
        let datasource = GridViewDataSource()
        let prefetchDataSource = GridViewPrefetchDataSource()
        let searchControllerDelegate = GridSearchResultsDelegate()
        
        let viewController = GridViewController(
            presenter: presenter,
            delegate: delegate,
            datasource: datasource,
            prefetchDataSource: prefetchDataSource,
            searchControllerDelegate: searchControllerDelegate
        )
        
        return viewController
    }
    
    private func favoriteViewController() -> UIViewController {
        let presenter = serviceLocator.favoritePresenter
        let delegate = FavoriteViewDelegate()
        let datasource = FavoriteViewDataSource()
        
        let viewController = FavoriteViewController(
            presenter: presenter,
            delegate: delegate,
            datasource: datasource
        )
        
        return viewController
    }
    
    private func detailViewController() -> UIViewController {
        let presenter = serviceLocator.detailPresenter
        let delegate = DetailViewDelegate()
        let datasource = DetailViewDataSource()
        
        let viewController = DetailViewController(
            presenter: presenter,
            delegate: delegate,
            datasource: datasource
        )
        
        return viewController
    }
}

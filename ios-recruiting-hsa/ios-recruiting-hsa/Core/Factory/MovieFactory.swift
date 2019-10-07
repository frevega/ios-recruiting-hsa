//
//  MovieFactory.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class MovieFactory {
    private let serviceLocator: ServiceLocator
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
    
    func tabBarController() -> UITabBarController {
        let viewController = UITabBarController()
        
        let gridController = gridViewController()
        gridController.tabBarItem = UITabBarItem(title: Constants.Labels.gridTitle,
                                                 image: UIImage(named: "list_icon"),
                                                 tag: 0
        )
        
        let favoritesController = favoritesViewController()
        favoritesController.tabBarItem = UITabBarItem(title: Constants.Labels.favoritesTitle,
                                                      image: UIImage(named: "favorite_empty_icon"),
                                                      tag: 1
        )
        
        viewController.viewControllers = [gridController, favoritesController].map { UINavigationController(rootViewController: $0)}
        viewController.tabBar.barTintColor = Constants.Colors.brand
        viewController.tabBar.tintColor = .black
        
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
    
    private func favoritesViewController() -> UIViewController {
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
    
    func detailViewController() -> UIViewController {
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

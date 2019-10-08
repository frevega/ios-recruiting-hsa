//
//  FavoriteCoordinatorImpl.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class FavoriteCoordinatorImpl: FavoriteCoordinator {
    var viewController: UIViewController
    var navigationController: UINavigationController
    
    init(viewController: UIViewController,
         navigationController: UINavigationController
        ) {
        self.viewController = viewController
        self.navigationController = navigationController
        navigationController.viewControllers = [viewController]
        prepareViewController()
    }
    
    private func prepareViewController() {
        viewController.tabBarItem = UITabBarItem(title: Constants.Labels.favoritesTitle,
                                                 image: UIImage(named: "favorite_empty_icon"),
                                                 tag: 1
        )
    }
}

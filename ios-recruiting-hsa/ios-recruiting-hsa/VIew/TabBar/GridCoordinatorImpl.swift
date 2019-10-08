//
//  GridCoordinatorImpl.swift
//  ios-recruiting-hsa
//
//  Created on 10/8/19.
//

import UIKit

class GridCoordinatorImpl: GridCoordinator {
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
        if let viewController = viewController as? GridViewController {
            viewController.coordinator = self
            viewController.tabBarItem = UITabBarItem(title: Constants.Labels.gridTitle,
                                                     image: UIImage(named: "list_icon"),
                                                     tag: 0
            )
        }
    }
    
    func goToDetail(id: Int) {
        if let detailController = ViewFactory.viewController(viewType: .detail) as? DetailViewController {
            detailController.movieId = id
            detailController.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(detailController, animated: true)
        }
    }
}

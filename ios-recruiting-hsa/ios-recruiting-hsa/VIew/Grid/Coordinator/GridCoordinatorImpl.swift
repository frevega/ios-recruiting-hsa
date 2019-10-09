//
//  GridCoordinatorImpl.swift
//  ios-recruiting-hsa
//
//  Created on 10/8/19.
//

import UIKit

class GridCoordinatorImpl: GridCoordinator {
    private let viewController: UIViewController
    let navigationController: UINavigationController
    
    init(viewController: UIViewController,
         navigationController: UINavigationController
    ) {
        self.viewController = viewController
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.viewControllers = [viewController]
        prepareViewController()
    }
    
    private func prepareViewController() {
        if let viewController = viewController as? GridView {
            viewController.attach(coordinator: self)
        }
        viewController.tabBarItem = UITabBarItem(
            title: Constants.Labels.gridTitle,
            image: UIImage(named: "list_icon"),
            tag: 0
        )
    }
    
    func showDetail(id: Int) {
        if let detailController = ViewFactory.viewController(viewType: .detail) as? DetailViewController {
            detailController.movieId = id
            detailController.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(detailController, animated: true)
        }
    }
}

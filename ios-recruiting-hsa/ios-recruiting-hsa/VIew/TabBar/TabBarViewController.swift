//
//  TabBarViewController.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class TabBarViewController: UITabBarController {
    private let gridCoordinator: Coordinator
    private let favoriteCoordinator: Coordinator
    
    init(gridCoordinator: Coordinator,
         favoriteCoordinator: Coordinator
    ) {
        self.gridCoordinator = gridCoordinator
        self.favoriteCoordinator = favoriteCoordinator
        super.init(nibName: String(describing: TabBarViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabBar()
        prepareViewControllers()
    }
    
    private func prepareTabBar() {
        tabBar.barTintColor = Constants.Colors.brand
        tabBar.tintColor = .black
    }
    
    private func prepareViewControllers() {
        viewControllers = [
            gridCoordinator.navigationController,
            favoriteCoordinator.navigationController
        ]
    }
}

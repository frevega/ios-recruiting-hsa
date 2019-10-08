//
//  TabBarViewController.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class TabBarViewController: UITabBarController {
    private let gridCoordinator: GridCoordinator
    private let favoriteCoordinator: FavoriteCoordinator
    
    init(gridCoordinator: GridCoordinator,
         favoriteCoordinator: FavoriteCoordinator
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
        childrenControllers()
    }
    
    private func childrenControllers() {
        viewControllers = [
            gridCoordinator.navigationController,
            favoriteCoordinator.navigationController
        ]
    }
}

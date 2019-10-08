//
//  DetailViewFactory.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class DetailViewFactory {
    private let serviceLocator: ServiceLocator
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
    
    func viewController() -> UIViewController {
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

//
//  ViewFactory.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

enum ViewTypes {
    case tab, detail
}

class ViewFactory {
    private static var serviceLocator = ServiceLocator()
    
    class func viewController(viewType: ViewTypes) -> UIViewController {
        var viewController: UIViewController
        
        switch viewType {
        case .tab:
            viewController = TabBarViewFactory(serviceLocator: serviceLocator).viewController()
        case .detail:
            viewController = DetailViewFactory(serviceLocator: serviceLocator).viewController()
        }
        
        return viewController
    }
}

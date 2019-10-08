//
//  Coordinator.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

protocol Coordinator: class {
    var viewController: UIViewController { get set }
    var navigationController: UINavigationController { get set }
}

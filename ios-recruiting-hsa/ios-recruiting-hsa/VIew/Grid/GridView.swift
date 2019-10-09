//
//  GridView.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import Foundation

protocol GridView: BaseView {
    func show(rows indexes: [IndexPath]?, shouldReload: Bool)
    func attach(coordinator: GridCoordinator)
}

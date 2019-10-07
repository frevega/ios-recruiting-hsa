//
//  GridViewPrefetchDataSource.swift
//  ios-recruiting-hsa
//
//  Created on 8/14/19.
//

import UIKit

class GridViewPrefetchDataSource: NSObject {
    private var view: GridViewController?
    
    func attach(view: GridViewController) {
        self.view = view
    }
}

extension GridViewPrefetchDataSource: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if let view = view, indexPaths.contains(where: view.isLoadingCell), !view.isSearchActive {
            view.fetchPopularMovies()
        }
    }
}

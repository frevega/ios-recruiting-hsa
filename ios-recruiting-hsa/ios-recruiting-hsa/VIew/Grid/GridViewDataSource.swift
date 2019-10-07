//
//  GridViewDatasource.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class GridViewDataSource: NSObject {
    private var view: GridViewController?
    
    func attach(view: GridViewController) {
        self.view = view
    }
}

extension GridViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let view = view {
            return view.isSearchActive ? view.localSearchedMovies.count : view.totalMovieCount
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: MovieCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCollectionViewCell
        if let view = view {
            var data = view.isSearchActive ? view.localSearchedMovies : view.movies
            if view.isLoadingCell(for: indexPath) {
                cell?.configure(imageUrl: nil, name: "-----")
            } else {
                cell?.configure(imageUrl: data[indexPath.row].posterPath,
                                name: data[indexPath.row].title
                )
            }
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    /*func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerName = String(describing: UICollectionViewCell.self)
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerName, for: indexPath)
        
        if let view = view {
            header.addSubview(view.searchController.searchBar)
        }
        
        return header
    }*/
}

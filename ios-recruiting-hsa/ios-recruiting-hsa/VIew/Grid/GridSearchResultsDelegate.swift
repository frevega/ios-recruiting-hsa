//
//  GridSearchResultsDelegate.swift
//  ios-recruiting-hsa
//
//  Created on 8/20/19.
//

import UIKit

class GridSearchResultsDelegate: NSObject {
    private var view: GridViewController?
    
    func attach(view: GridViewController) {
        self.view = view
    }
}

extension GridSearchResultsDelegate: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            view?.localSearchPopularMovies(text: text)
        }
    }
}

extension GridSearchResultsDelegate: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view?.isSearchActive = true
        view?.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view?.isSearchActive = false
        view?.collectionView.reloadData()
    }
}

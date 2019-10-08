//
//  GridViewDelegate.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class GridViewDelegate: NSObject {
    private var view: GridViewController?
    
    func attach(view: GridViewController) {
        self.view = view
    }
}

extension GridViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let view = view/*, let viewController = ViewFactory.viewController(viewType: .detail) as? DetailViewController*/ {
            var data = view.isSearchActive ? view.localSearchedMovies : view.movies
//            viewController.movieId = data[indexPath.row].id
//            viewController.hidesBottomBarWhenPushed = true
//            view.pushViewController(viewController: viewController)
            view.coordinator?.goToDetail(id: data[indexPath.row].id)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let view = view {
            let indexPathsToReload = view.visibleIndexPathsToReload(intersecting: view.collectionView.indexPathsForVisibleItems)
            view.collectionView.reloadItems(at: indexPathsToReload)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = GridConstants.Collection.sectionInsets.left * (GridConstants.Collection.itemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / GridConstants.Collection.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + (widthPerItem * Constants.Images.gridMultiplier))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return GridConstants.Collection.sectionInsets 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return GridConstants.Collection.sectionInsets.left 
    }
}

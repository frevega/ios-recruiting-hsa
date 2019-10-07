//
//  GridPresenter.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

protocol GridPresenter {
    func attach(view: GridView)
    func popularMovies()
    func getMovies() -> [MovieView]
    func getLocalSearchedMovies() -> [MovieView]
    func getTotalMovieCount() -> Int
    func localSearchPopularMovies(text: String)
}

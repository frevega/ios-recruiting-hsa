//
//  GridPresenterImpl.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import Foundation

class GridPresenterImpl {
    weak var view: GridView?
    private let movieUseCase: MovieUseCase
    private let movieResponseViewToModel: Mapper<MovieResponseView, MovieResponseModel>
    private let errorViewToModel: Mapper<ErrorView, ErrorModel>
    private var isFetchingPopularMovies = false
    private var popularPageNumber = 1
    private var movies = [MovieView]()
    private var localSearchedMovies = [MovieView]()
    private var movieResponse: MovieResponseView? = nil
    private var previousTotalMovieCount: Int = 0
    
    init(movieUseCase: MovieUseCase,
         movieResponseViewToModel: Mapper<MovieResponseView, MovieResponseModel>,
         errorViewToModel: Mapper<ErrorView, ErrorModel>
        ) {
        self.movieUseCase = movieUseCase
        self.movieResponseViewToModel = movieResponseViewToModel
        self.errorViewToModel = errorViewToModel
    }
    
    private func calculateIndexPathsToReload(from newMovies: [MovieView]) -> [IndexPath] {
        let startIndex = movies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex ..< endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

extension GridPresenterImpl: GridPresenter {
    func attach(view: GridView) {
        self.view = view
        view.prepare()
    }
    
    func popularMovies() {
        guard !isFetchingPopularMovies else {
            return
        }
        isFetchingPopularMovies = true
        view?.showLoading()
        movieUseCase.fetchMovies(page: popularPageNumber) { (responseModel, error) in
            self.isFetchingPopularMovies = false
            self.view?.hideLoading()
            guard let responseModel = responseModel else {
                if let error = error {
                    self.view?.show(error: self.errorViewToModel.reverseMap(value: error))
                }
                return
            }
            
            if responseModel.results.count > 0 {
                self.movieResponse = self.movieResponseViewToModel.reverseMap(value: responseModel)
                if let movieResponse = self.movieResponse {
                    self.movies.append(contentsOf: movieResponse.results)
                    let indexes = movieResponse.page > 1 ? self.calculateIndexPathsToReload(from: movieResponse.results) : nil
                    let shouldReload = self.previousTotalMovieCount != movieResponse.totalResults
                    self.view?.show(rows: indexes, shouldReload: shouldReload)
                    self.previousTotalMovieCount = movieResponse.totalResults
                    self.popularPageNumber += 1
                }
            }
        }
    }
    
    func getMovies() -> [MovieView] {
        let movies = self.movies
        return movies
    }
    
    func getLocalSearchedMovies() -> [MovieView] {
        let localSearchedMovies = self.localSearchedMovies
        return localSearchedMovies
    }
    
    func getTotalMovieCount() -> Int {
        return movieResponse?.totalResults ?? 0
    }
    
    func localSearchPopularMovies(text: String) {
        localSearchedMovies = movies
        if !text.isEmpty {
            localSearchedMovies = movies.filter({ $0.title.lowercased().contains(text.lowercased()) })
            view?.show(rows: nil, shouldReload: true)
        }
    }
}

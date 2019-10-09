//
//  FavoritepresenterImpl.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

class FavoritePresenterImpl {
    private weak var view: FavoriteView?
    private let movieUseCase: MovieUseCase
    private let favoriteMovieViewToModel: Mapper<FavoriteMovieView, FavoriteMovieModel>
    private let errorViewToModel: Mapper<ErrorView, ErrorModel>
    private var favorites = [FavoriteMovieView]()
    
    init(movieUseCase: MovieUseCase,
         favoriteMovieViewToModel: Mapper<FavoriteMovieView, FavoriteMovieModel>,
         errorViewToModel: Mapper<ErrorView, ErrorModel>
    ) {
        self.movieUseCase = movieUseCase
        self.favoriteMovieViewToModel = favoriteMovieViewToModel
        self.errorViewToModel = errorViewToModel
    }
}

extension FavoritePresenterImpl: FavoritePresenter {
    func attach(view: FavoriteView) {
        self.view = view
        view.prepare()
    }
    
    func favoriteMovies() {
        view?.showLoading()
        movieUseCase.fetch { (movieModels, error) in
            guard let movieModels = movieModels else {
                if let error = error {
                    self.view?.show(error: self.errorViewToModel.reverseMap(value: error))
                    self.view?.hideLoading()
                }
                return
            }
            
            self.favorites.removeAll()
            self.favorites.append(contentsOf: self.favoriteMovieViewToModel.reverseMap(values: movieModels));
            self.view?.show()
            self.view?.hideLoading()
        }
    }
    
    func deleteFavorite(movie: FavoriteMovieView) {
        view?.showLoading()
        movieUseCase.delete(movie: self.favoriteMovieViewToModel.map(value: movie)) { (error) in
            guard let error = error else {
                self.favorites.removeAll(where: { $0.id == movie.id })
                self.view?.hideLoading()
                return
            }
            
            self.view?.show(error: self.errorViewToModel.reverseMap(value: error))
            self.view?.hideLoading()
        }
    }
    
    func favoriteMovieArray() -> [FavoriteMovieView] {
        let favorites = self.favorites
        return favorites
    }
}

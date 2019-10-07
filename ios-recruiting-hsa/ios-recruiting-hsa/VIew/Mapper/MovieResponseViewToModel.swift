//
//  MovieResponseViewToModel.swift
//  ios-recruiting-hsa
//
//  Created on 14-08-19.
//

class MovieResponseViewToModel: Mapper<MovieResponseView, MovieResponseModel> {
    private let movieViewToModel: Mapper<MovieView, MovieModel>
    
    init(movieViewToModel: Mapper<MovieView, MovieModel>) {
        self.movieViewToModel = movieViewToModel
    }
    
    override func reverseMap(value: MovieResponseModel) -> MovieResponseView {
        return MovieResponseView(page: value.page,
                                 totalResults: value.totalResults,
                                 totalPages: value.totalPages,
                                 results: movieViewToModel.reverseMap(values: value.results)
        )
    }
}

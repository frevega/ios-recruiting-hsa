//
//  MovieRestApiImpl.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

import Alamofire

class MovieRestApiImpl: MovieRestApi {
    private let sessionManager: SessionManager
    private let codableHelper: CodableHelper
    
    init(sessionManager: SessionManager = SessionManager.default,
         codableHelper: CodableHelper) {
        self.sessionManager = sessionManager
        self.codableHelper = codableHelper
    }
    
    func fetchMovies(page: Int, endpoint: Endpoints.Movies, completionHandler: @escaping (MovieResponseEntity?, ErrorEntity?) -> Void) {
        guard let url = URL(
            string: String(format: endpoint.rawValue, MovieURL.Prod.url.rawValue, MovieURL.Prod.apiKey.rawValue, page)
        ) else {
            completionHandler(nil, ErrorEntity(statusMessage: Constants.ErrorMessages.serverError, statusCode: 0))
            return
        }
        
        sessionManager.request(url).responseData { (response) in
            if let data = response.data, let entity: MovieResponseEntity = try? self.codableHelper.decodeNetworkObject(object: data) {
                completionHandler(entity, nil)
            } else if let data = response.data, let error: ErrorEntity = try? self.codableHelper.decodeNetworkObject(object: data) {
                completionHandler(nil, error)
            } else {
                completionHandler(nil, ErrorEntity(statusMessage: Constants.ErrorMessages.serverError, statusCode: 0))
            }
        }
    }
    
    func fetchMovieDetail(id: Int, endpoint: Endpoints.Movies, completionHandler: @escaping (MovieDetailEntity?, ErrorEntity?) -> Void) {
        guard let url = URL(
            string: String(format: endpoint.rawValue, MovieURL.Prod.url.rawValue, id, MovieURL.Prod.apiKey.rawValue)
            ) else {
                completionHandler(nil, ErrorEntity(statusMessage: Constants.ErrorMessages.serverError, statusCode: 0))
                return
        }
        
        sessionManager.request(url).responseData { (response) in
            if let data = response.data, let entity: MovieDetailEntity = try? self.codableHelper.decodeNetworkObject(object: data) {
                completionHandler(entity, nil)
            } else if let data = response.data, let error: ErrorEntity = try? self.codableHelper.decodeNetworkObject(object: data) {
                completionHandler(nil, error)
            } else {
                completionHandler(nil, ErrorEntity(statusMessage: Constants.ErrorMessages.serverError, statusCode: 0))
            }
        }
    }
}

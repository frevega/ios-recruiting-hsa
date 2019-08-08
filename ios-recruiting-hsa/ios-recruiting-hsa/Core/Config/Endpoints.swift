//
//  Endpoints.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

enum Endpoints {
    enum Movies: String {
        case genres = "/genre/movie/list"
        case popular = "/popular?page="
        case movieDetail = "/movie/%d"
    }
}
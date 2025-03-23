//
//  MovieAPIService.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 28/07/24.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchPopularMovies(completion: @escaping (NetworkState<[MovieEntityProtocol]>) -> Void)
    init(networkService: NetworkServiceProtocol) // new
}



//
//  TMDBMovieService.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation


class TMDBMovieService: MovieServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private var pageIndex = 1

    required init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchPopularMovies(completion: @escaping (NetworkState<[MovieEntityProtocol]>) -> Void) {
        let urlString = "\(TMDBMovieServiceConstants.baseURL)/movie/popular?api_key=\(TMDBMovieServiceConstants.apiKey)&page=\(pageIndex)"
        
        networkService.fetchData(
            from: urlString,
            method: .GET,
            headers: nil,
            requestBody: nil
        ) { result in
            switch result {
            case .success(let data):
                do {
                    let movieResponse = try JSONDecoder().decode(TMDBMovieResponse.self, from: data)
                    self.pageIndex += 1
                    completion(.success(movieResponse.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

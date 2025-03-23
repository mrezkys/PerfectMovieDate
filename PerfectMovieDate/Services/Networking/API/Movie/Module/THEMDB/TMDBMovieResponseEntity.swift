//
//  MovieResponseEntity.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

struct TMDBMovieResponse: Decodable {
    let results: [TMDBMovieModel]
}

struct TMDBMovieModel: Decodable, MovieEntityProtocol {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}

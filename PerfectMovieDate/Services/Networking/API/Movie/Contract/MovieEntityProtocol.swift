//
//  MovieEntityProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 05/08/24.
//

import Foundation

protocol MovieEntityProtocol {
    var id: Int { get }
    var title: String { get }
    var overview: String { get }
    var posterPath: String? { get }
}

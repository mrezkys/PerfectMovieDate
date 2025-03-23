//
//  NetworkState.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 28/07/24.
//

import Foundation

enum NetworkState<T> {
    case loading
    case success(T)
    case failure(Error)
}

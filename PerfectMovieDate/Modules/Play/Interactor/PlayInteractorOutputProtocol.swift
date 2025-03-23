//
//  PlayInteractorOutputProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol PlayInteractorOutputProtocol: AnyObject {
    func didFetchMovie(results: [MovieEntityProtocol])
    func didFailToFetchMovies(_ error: Error)
    func didStartLoadingMovies()
    
    func didSuccessLoveMovie()
    func didFailedLoveMovie(_ error: Error)
    
    func didFoundMatchedMovie(movieId: Int)
    func didNotFoundMatchedMovie()
}

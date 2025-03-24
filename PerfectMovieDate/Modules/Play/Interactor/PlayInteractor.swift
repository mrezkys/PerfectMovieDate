//
//  PlayInteractor.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 17/06/24.
//

import UIKit

class PlayInteractor: PlayInteractorProtocol {
    var presenter: PlayInteractorOutputProtocol?

    var imageLoadingService: ImageLoadingServiceProtocol
    var movieService: MovieServiceProtocol
    var roomRepository: RoomRepository

    var roomCode: String
    var playerType: PlayerType
    
    init(
        repository: RoomRepository,
        movieService: MovieServiceProtocol,
        roomCode: String,
        playerType: PlayerType,
        imageLoadingService: ImageLoadingServiceProtocol = ImageLoadingService()
    ) {
        self.roomRepository = repository
        self.movieService = movieService
        self.roomCode = roomCode
        self.playerType = playerType
        self.imageLoadingService = imageLoadingService
    }
    
    func fetchMovies() {
        movieService.fetchPopularMovies { [weak self] networkState in
            switch networkState {
            case .loading:
                self?.presenter?.didStartLoadingMovies()
            case .success(let movies):
                self?.presenter?.didFetchMovie(results: movies)
            case .failure(let error):
                self?.presenter?.didFailToFetchMovies(error)
            }
        }
    }
    
    func loveMovie(_ id: Int) {
        roomRepository.addLovedMovie(id, in: roomCode, as: playerType) { result in
            switch result {
            case .success(_):
                self.presenter?.didSuccessLoveMovie()
            case .failure(let failure):
                self.presenter?.didFailedLoveMovie(failure)
            }
        }
    }
    
    func checkMatchedMovie() {
        roomRepository.checkMatchedMovie(in: roomCode) { result in
            switch result {
            case .success(let matchedMovieId):
                self.presenter?.didFoundMatchedMovie(movieId: matchedMovieId)
            case .failure(_):
                self.presenter?.didNotFoundMatchedMovie()
            }
        }
    }

    func loadMoviePosterImage(from posterPath: String, completion: @escaping (UIImage?) -> Void) {
        // Construct full TMDB image URL with base path
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let fullURLString = posterPath.hasPrefix("http") ? posterPath : baseURL + posterPath
        
        guard let url = URL(string: fullURLString) else {
            completion(nil)
            return
        }
        
        imageLoadingService.loadImage(from: url, completion: completion)
    }
}

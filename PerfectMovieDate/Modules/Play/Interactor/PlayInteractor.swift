//
//  PlayInteractor.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 17/06/24.
//

import Foundation

class PlayInteractor: PlayInteractorProtocol {
    var presenter: PlayInteractorOutputProtocol?
    private let movieService: MovieServiceProtocol
    private let repository: RoomRepository
    var roomCode: String
    var playerType: PlayerType
    
    init(repository: RoomRepository, movieService: MovieServiceProtocol, roomCode: String, playerType: PlayerType) {
        self.repository = repository
        self.movieService = movieService
        self.roomCode = roomCode
        self.playerType = playerType
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
        repository.addLovedMovie(id, in: roomCode, as: playerType) { result in
            switch result {
            case .success(_):
                self.presenter?.didSuccessLoveMovie()
            case .failure(let failure):
                self.presenter?.didFailedLoveMovie(failure)
            }
        }
    }
    
    func checkMatchedMovie() {
        repository.checkMatchedMovie(in: roomCode) { result in
            switch result {
            case .success(let matchedMovieId):
                self.presenter?.didFoundMatchedMovie(movieId: matchedMovieId)
            case .failure(_):
                self.presenter?.didNotFoundMatchedMovie()
            }
        }
    }
}

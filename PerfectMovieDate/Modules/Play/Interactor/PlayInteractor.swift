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
    
    init(repository: RoomRepository, movieService: MovieServiceProtocol) {
        self.repository = repository
        self.movieService = movieService
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
    
    func loveMovie(_ id: String, in roomCode: String, as player: PlayerType) {
        repository.addLovedMovie(id, in: roomCode, as: player) { result in
            switch result {
            case .success(_):
                self.presenter?.didSuccessLoveMovie()
            case .failure(let failure):
                self.presenter?.didFailedLoveMovie(failure)
            }
        }
    }
}

//
//  PlayPresenter.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 17/06/24.
//

import Foundation

class PlayPresenter: PlayPresenterProtocol {
    var view: PlayViewProtocol?
    var router: PlayRouterProtocol?
    var interactor: PlayInteractorProtocol?
    
    var movies: [MovieEntityProtocol] = []
    
    var currentMovie: Int = 0
    
    func viewDidLoad() {
        interactor?.fetchMovies()
    }
    
    func didTapYes() {
//        interactor?.loveMovie(<#T##id: String##String#>, in: <#T##String#>, as: <#T##PlayerType#>)
        currentMovie += 1
        loadMovie()
    }
    
    func didTapNo() {
    }
    
    private func loadMovie() {
        if let movie = movies[safe: currentMovie] {
            view?.updateCurrentMovie(with: movie)
        } else {
            interactor?.fetchMovies()
        }
    }
}

extension PlayPresenter: PlayInteractorOutputProtocol {
    func didFetchMovie(results: [MovieEntityProtocol]) {
        movies = results
        currentMovie = 0
        loadMovie()
    }
    
    func didFailToFetchMovies(_ error: Error) {
        print("Error", error)
    }
    
    func didStartLoadingMovies() {
        print("Start Loading")
    }
    
    
    func didSuccessLoveMovie() {
        print("SuccessLoveMovie")
    }
    
    func didFailedLoveMovie(_ error: Error) {
        print("Error", error)
    }
}

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

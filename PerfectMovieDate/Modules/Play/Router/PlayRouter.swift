//
//  PlayRouter.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 17/06/24.
//

import UIKit

class PlayRouter: PlayRouterProtocol {
    static func createModule(with code: String, as player: PlayerType) -> UIViewController {
        let firestoreService: FirestoreServiceProtocol = FirestoreService()

        let view = PlayViewController()
        let presenter: PlayPresenterProtocol = PlayPresenter()
        let repository: RoomRepository = FirebaseRoomRepository(db: firestoreService)
        let movieService: MovieServiceProtocol = TMDBMovieService()
        let interactor: PlayInteractorProtocol = PlayInteractor(
            repository: repository,
            movieService: movieService
        )
        let router: PlayRouterProtocol = PlayRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter as? PlayInteractorOutputProtocol

        return view
    }
}

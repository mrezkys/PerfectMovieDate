//
//  LobbyRouter.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 10/06/24.
//

import UIKit

class LobbyRouter: LobbyRouterProtocol {
    static func createModule(as playerType: PlayerType) -> UIViewController {
        let view = LobbyViewController()
        let presenter: LobbyPresenterProtocol = LobbyPresenter()
        let repository: RoomRepository = FirebaseRoomRepository() // Use FirebaseRoomRepository here
        let interactor: LobbyInteractorProtocol = LobbyInteractor(repository: repository)
        let router: LobbyRouterProtocol = LobbyRouter()

        view.presenter = presenter
        presenter.player = playerType
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter as? LobbyInteractorOutputProtocol

        return view
    }
    
    static func createModule(as playerType: PlayerType, with roomCode: String) -> UIViewController {
        let view = LobbyViewController()
        let presenter: LobbyPresenterProtocol = LobbyPresenter()
        let repository: RoomRepository = FirebaseRoomRepository() // Use FirebaseRoomRepository here
        let interactor: LobbyInteractorProtocol = LobbyInteractor(repository: repository)
        let router: LobbyRouterProtocol = LobbyRouter()

        view.presenter = presenter
        presenter.player = playerType
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.roomCode = roomCode
        interactor.presenter = presenter as? LobbyInteractorOutputProtocol

        return view
    }

    func navigateToPlay(from view: LobbyViewProtocol, with code: String, as player: PlayerType) {
        let playViewController = PlayRouter.createModule(with: code, as: player)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(playViewController, animated: true)
        }
    }
}

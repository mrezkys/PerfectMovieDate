//
//  WelcomeRouter.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 09/06/24.
//

import UIKit

class WelcomeRouter: WelcomeRouterProtocol {
    static func createModule() -> UIViewController {
        let view = WelcomeViewController()
        let presenter: WelcomePresenterProtocol = WelcomePresenter()
        let repository: RoomRepository = FirebaseRoomRepository()
        let interactor: WelcomeInteractorProtocol = WelcomeInteractor(repository: repository)
        let router: WelcomeRouterProtocol = WelcomeRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter as? WelcomeInteractorOutputProtocol

        return view
    }
    
    func navigateToLobby(from view: WelcomeViewProtocol, as player: PlayerType) {
        let lobbyViewController = LobbyRouter.createModule(as: player)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(lobbyViewController, animated: true)
        }
    }

    func navigateToLobby(from view: WelcomeViewProtocol, with roomCode: String, as player: PlayerType) {
        let lobbyViewController = LobbyRouter.createModule(as: player, with: roomCode)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(lobbyViewController, animated: true)
        }
    }
}

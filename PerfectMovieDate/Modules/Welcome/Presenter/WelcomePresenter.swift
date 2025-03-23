//
//  WelcomePresenter.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 09/06/24.
//

import Foundation

class WelcomePresenter: WelcomePresenterProtocol {
    var view: WelcomeViewProtocol?
    var router: WelcomeRouterProtocol?
    var interactor: WelcomeInteractorProtocol?

    func createRoom() {
        interactor?.createRoom()
    }

    func joinRoom() {
        if let view = view {
            router?.navigateToLobby(from: view, as: PlayerType.player2)
        }
    }
    
    // MARK: - WelcomeInteractorOutputProtocol
    func didCreateRoom(with roomCode: String) {
        if let view = view {
            router?.navigateToLobby(from: view, with: roomCode, as: PlayerType.player1)
        }
    }

    func didFailToCreateRoom(_ error: Error) {
        view?.displayError(error)
    }
}

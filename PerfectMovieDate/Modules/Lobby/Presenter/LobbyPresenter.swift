//
//  LobbyPresenter.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 10/06/24.
//

import Foundation

class LobbyPresenter: LobbyPresenterProtocol {
    var player: PlayerType?
    
    var roomCode: String?

    var view: LobbyViewProtocol?
    
    var interactor: LobbyInteractorProtocol?
    
    var router: LobbyRouterProtocol?
    
    func viewDidLoad() {
        if let roomCode = roomCode {
            view?.displayRoomCode(roomCode)
        } else {
            
        }
    }

    func joinRoom(with code: String) {
        switch player {
        case .player1:
            if let view = view, let roomCode = roomCode {
                router?.navigateToPlay(from: view, with: roomCode, as: .player1)
            }
        case .player2:
            interactor?.joinRoom(for: code)
        case nil:
            break
        }
    }
}

extension LobbyPresenter: LobbyInteractorOutputProtocol {
    func didJoinRoom(roomCode: String) {
        if let view = view {
            router?.navigateToPlay(from: view, with: roomCode, as: .player2)
        }
    }

    func didFailJoinRoom(_ error: Error) {
        if let view = view {
            view.displayError(error)
        }
    }
}

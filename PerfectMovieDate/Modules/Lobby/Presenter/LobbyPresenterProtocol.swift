//
//  LobbyPresenterProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol LobbyPresenterProtocol: AnyObject {
    var view: LobbyViewProtocol? { get set }
    var interactor: LobbyInteractorProtocol? { get set }
    var router: LobbyRouterProtocol? { get set }
    var roomCode: String? { get set }
    var player: PlayerType? { get set }

    func viewDidLoad()
    func joinRoom(with code: String)
}

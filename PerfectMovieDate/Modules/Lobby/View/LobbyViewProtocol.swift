//
//  LobbyViewProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol LobbyViewProtocol: AnyObject {
    var presenter: LobbyPresenterProtocol? { get set }
    func displayRoomCode(_ code: String)
    func displayError(_ error: Error)
}

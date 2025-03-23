//
//  LobbyInteractorOutputProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol LobbyInteractorOutputProtocol: AnyObject {
    func didJoinRoom(roomCode: String)
    func didFailJoinRoom(_ error: Error)
}

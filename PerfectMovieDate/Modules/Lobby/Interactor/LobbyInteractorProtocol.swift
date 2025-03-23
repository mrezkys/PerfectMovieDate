//
//  LobbyInteractorProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol LobbyInteractorProtocol: AnyObject {
    var presenter: LobbyInteractorOutputProtocol? { get set }
    func joinRoom(for code: String)
}

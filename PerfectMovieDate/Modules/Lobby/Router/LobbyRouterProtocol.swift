//
//  LobbyRouterProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import UIKit

// Router Protocol
protocol LobbyRouterProtocol: AnyObject {
    static func createModule(as playerType: PlayerType, with roomCode: String) -> UIViewController
    static func createModule(as playerType: PlayerType) -> UIViewController
    func navigateToPlay(from view: LobbyViewProtocol, with code: String, as player: PlayerType)
}

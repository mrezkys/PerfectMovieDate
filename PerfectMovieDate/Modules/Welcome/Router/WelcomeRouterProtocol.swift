//
//  WelcomeRouterProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import UIKit

protocol WelcomeRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToLobby(from view: WelcomeViewProtocol, with roomCode: String, as player: PlayerType)
    func navigateToLobby(from view: WelcomeViewProtocol, as player: PlayerType)
}

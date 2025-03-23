//
//  WelcomePresenterProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol WelcomePresenterProtocol: WelcomeInteractorOutputProtocol {
    var view: WelcomeViewProtocol? { get set }
    var interactor: WelcomeInteractorProtocol? { get set }
    var router: WelcomeRouterProtocol? { get set }

    func createRoom()
    func joinRoom()
}

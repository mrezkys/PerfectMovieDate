//
//  WelcomeInteractorProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol WelcomeInteractorProtocol: AnyObject {
    var presenter: WelcomeInteractorOutputProtocol? { get set }
    func createRoom()
}

//
//  WelcomeInteractorOutputProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol WelcomeInteractorOutputProtocol: AnyObject {
    func didCreateRoom(with roomCode: String)
    func didFailToCreateRoom(_ error: Error)
}

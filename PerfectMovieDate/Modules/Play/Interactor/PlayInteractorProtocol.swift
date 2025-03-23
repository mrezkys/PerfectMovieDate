//
//  PlayInteractorProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol PlayInteractorProtocol: AnyObject {
    var presenter: PlayInteractorOutputProtocol? { get set }
    func fetchMovies()
    func loveMovie(_ id: String, in roomCode: String, as player: PlayerType)
}

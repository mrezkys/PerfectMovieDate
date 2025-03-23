//
//  PlayInteractorProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol PlayInteractorProtocol: AnyObject {
    var presenter: PlayInteractorOutputProtocol? { get set }
    var roomCode: String { get set }
    var playerType: PlayerType { get set }

    func fetchMovies()
    func loveMovie(_ id: Int)
    func checkMatchedMovie()
}

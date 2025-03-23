//
//  PlayViewProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol PlayViewProtocol {
    var presenter: PlayPresenterProtocol? { get set }
    func updateCurrentMovie(with movie: MovieEntityProtocol)
}

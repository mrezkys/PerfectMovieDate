//
//  PlayViewProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import UIKit

protocol PlayViewProtocol {
    var presenter: PlayPresenterProtocol? { get set }
    
    func updateCurrentMovie(with movie: MovieEntityProtocol)
    func showMatchedMovieModal()
    func updatePosterImage(_ image: UIImage?)
}

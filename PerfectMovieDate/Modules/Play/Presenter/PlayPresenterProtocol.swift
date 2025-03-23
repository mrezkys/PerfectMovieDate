//
//  PlayPresenterProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol PlayPresenterProtocol: AnyObject {
    var view: PlayViewProtocol? { get set }
    var interactor: PlayInteractorProtocol? { get set }
    var router: PlayRouterProtocol? { get set }
    
    var movies: [MovieEntityProtocol] { get set }
    var currentMovie: Int { get set }
        
    func viewDidLoad()
    func didTapYes()
    func didTapNo()
    
}

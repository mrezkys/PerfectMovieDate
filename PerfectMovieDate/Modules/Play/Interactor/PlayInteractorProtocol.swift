//
//  PlayInteractorProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import UIKit

protocol PlayInteractorProtocol: AnyObject {
    var presenter: PlayInteractorOutputProtocol? { get set }
    
    // Injected services and repositories
    var roomRepository: RoomRepository { get set }
    var movieService: MovieServiceProtocol { get set }
    var imageLoadingService: ImageLoadingServiceProtocol { get set }
    
    var roomCode: String { get set }
    var playerType: PlayerType { get set }

    func loadMoviePosterImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
    func fetchMovies()
    func loveMovie(_ id: Int)
    func checkMatchedMovie()
}

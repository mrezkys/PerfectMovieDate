//
//  PlayViewController.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 17/06/24.
//

import UIKit

class PlayViewController: UIViewController, PlayViewProtocol {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var presenter: PlayPresenterProtocol?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    @IBAction func didTapNoButton(_ sender: Any) {
        presenter?.didTapNo()
    }

    @IBAction func didTapYesButton(_ sender: Any) {
        presenter?.didTapYes()
    }

    func updateCurrentMovie(with movie: MovieEntityProtocol) {
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            if let posterPath = movie.posterPath {
                self.presenter?.loadMoviePosterImage(urlString: posterPath)
            }
        }
    }
    
    func updatePosterImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.posterImage.image = image
        }
    }
    
    func showMatchedMovieModal() {
        let image = UIImage(systemName: "square.and.arrow.up.circle.fill")
        let modalVC = ModalViewController(
            image: image,
            title: "Matched Movie: Inception",
            agreeTitle: "End Session",
            cancelTitle: "Skip",
            onCancel: {
                print("User cancelled")
            },
            onAgree: {
                print("User agreed")
            }
        )
        
        present(modalVC, animated: true, completion: nil)
    }
    
}

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
    }

    @IBAction func didTapYesButton(_ sender: Any) {
        presenter?.didTapYes()
    }
    
    func updateCurrentMovie(with movie: MovieEntityProtocol) {
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            if let posterPath = movie.posterPath {
                if let imageUrl = URL(string: "https://image.tmdb.org/t/p/w400/\(posterPath)") {
                    self.loadImage(from: imageUrl)
                }
            }
        }
        
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: data)
            }
        }.resume()
    }
}

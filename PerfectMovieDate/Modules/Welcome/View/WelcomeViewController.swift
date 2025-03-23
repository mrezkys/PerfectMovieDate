//
//  WelcomeViewController.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 09/06/24.
//

import UIKit

class WelcomeViewController: UIViewController, WelcomeViewProtocol {
    
    var presenter: WelcomePresenterProtocol?

    @IBOutlet weak var createRoomButton: UIButton!
    @IBOutlet weak var joinRoomButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapCreateRoomButton(_ sender: Any) {
        presenter?.createRoom()
    }

    @IBAction func didTapJoinRoomButton(_ sender: Any) {
        presenter?.joinRoom()
    }

    func displayError(_ error: Error) {
        print("Error", error)
    }
}

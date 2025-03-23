//
//  LobbyViewController.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 10/06/24.
//

import UIKit

class LobbyViewController: UIViewController, LobbyViewProtocol {
    
    @IBOutlet weak var roomInput: UITextField!
    @IBOutlet weak var roomLabel: UILabel!
    var presenter: LobbyPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        roomLabel.isHidden = true
        presenter?.viewDidLoad()
    }
    
    @IBAction func didTapContinueButton(_ sender: Any) {
        if let roomCode = presenter?.roomCode {
            presenter?.joinRoom(with: roomCode)
        } else {
            presenter?.joinRoom(with: roomInput.text ?? "")
        }
    }
    
    func displayRoomCode(_ code: String) {
        roomLabel.text = code
        roomLabel.isHidden = false
        roomInput.isHidden = true
    }
    
    func displayError(_ error: Error) {
        print("error")
    }
    
}

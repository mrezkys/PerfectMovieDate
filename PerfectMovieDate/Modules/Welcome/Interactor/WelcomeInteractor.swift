//
//  WelcomeInteractor.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 09/06/24.
//

import Foundation

class WelcomeInteractor: WelcomeInteractorProtocol {
    weak var presenter: WelcomeInteractorOutputProtocol?
    private let repository: RoomRepository

    init(repository: RoomRepository) {
        self.repository = repository
    }

    func createRoom() {
        repository.generateUniqueRoomCode { [weak self] result in
            switch result {
            case .success(let roomCode):
                self?.repository.createUserRoom(roomCode: roomCode) { result in
                    switch result {
                    case .success:
                        self?.presenter?.didCreateRoom(with: roomCode)
                    case .failure(let error):
                        self?.presenter?.didFailToCreateRoom(error)
                    }
                }
            case .failure(let error):
                self?.presenter?.didFailToCreateRoom(error)
            }
        }
    }
}

//
//  LobbyInteractor.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 10/06/24.
//

import Foundation

class LobbyInteractor: LobbyInteractorProtocol {
    weak var presenter: LobbyInteractorOutputProtocol?
    private let repository: RoomRepository

    init(repository: RoomRepository) {
        self.repository = repository
    }

    func joinRoom(for code: String) {
        repository.isRoomCodeAvailable(code) { [weak self] result in
            switch result {
            case .success(let available):
                if available {
                    self?.presenter?.didFailJoinRoom(NSError(domain: "Room not available", code: 404, userInfo: nil))
                } else {
                    self?.presenter?.didJoinRoom(roomCode: code)
                }
            case .failure(let error):
                self?.presenter?.didFailJoinRoom(error)
            }
        }
    }
}

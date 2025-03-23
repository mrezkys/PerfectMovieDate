//
//  RoomRepository.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 28/07/24.
//

import Foundation
import Firebase

protocol RoomRepository {
    var db: FirestoreServiceProtocol { get set }
    func generateUniqueRoomCode(completion: @escaping (Result<String, Error>) -> Void)
    func createUserRoom(roomCode: String, completion: @escaping (Result<Void, Error>) -> Void)
    func invalidateRoomCode(roomCode: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func isRoomCodeAvailable(_ code: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func addLovedMovie(_ id: String, in roomCode: String, as player: PlayerType, completion: @escaping (Result<Void, Error>) -> Void)
}

class FirebaseRoomRepository: RoomRepository {
    var db: FirestoreServiceProtocol
    
    init(db: FirestoreServiceProtocol) {
        self.db = db
    }

    func generateUniqueRoomCode(completion: @escaping (Result<String, Error>) -> Void) {
        print("generateUniqueRoomCode()")
        DispatchQueue.global().async {
            var code: String
            repeat {
                code = String(format: "%04d", Int.random(in: 1000...9999))
                let exists = self.isRoomCodeAvailableSync(code)
                if exists == false {
                    DispatchQueue.main.async {
                        completion(.success(code))
                    }
                    return
                }
            } while true
        }
    }
    
    func addLovedMovie(_ id: String, in roomCode: String, as player: PlayerType, completion: @escaping (Result<Void, Error>) -> Void) {
        db.getDocument(collection: "rooms", documentId: roomCode) { result in
            switch result {
            case .success(var data):
                if var playerMovies = data[player.rawValue] as? [String] {
                    playerMovies.append(id)
                    data[player.rawValue] = playerMovies
                } else {
                    data[player.rawValue] = [id]
                }
                // update
                //                documentRef.updateData(updatedData) { error in
                //                    if let error = error {
                //                        completion(.failure(error))
                //                    } else {
                //                        completion(.success(()))
                //                    }
                //                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
//        let documentRef = db.collection("rooms").document(roomCode)
//        documentRef.getDocument { document, error in
//            if let document = document, document.exists {
//                var updatedData = document.data() ?? [:]
//                if var playerMovies = updatedData[player.rawValue] as? [String] {
//                    playerMovies.append(id)
//                    updatedData[player.rawValue] = playerMovies
//                } else {
//                    updatedData[player.rawValue] = [id]
//                }
//                
//                documentRef.updateData(updatedData) { error in
//                    if let error = error {
//                        completion(.failure(error))
//                    } else {
//                        completion(.success(()))
//                    }
//                }
//            } else {
//                completion(.failure(error ?? NSError(domain: "Room not found", code: 404, userInfo: nil)))
//            }
//        }
    }
    func createUserRoom(roomCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        print("createUserRoom()")
        let room = ["code": roomCode, "player1": [], "player2": nil] as [String : Any]
        db.collection("rooms").document(roomCode).setData(room) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func invalidateRoomCode(roomCode: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        db.collection("rooms").document(roomCode).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func isRoomCodeAvailable(_ code: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        db.getDocument(collection: "rooms", documentId: code) { result in
            switch result {
            case .success(let success):
                // If document successfully retrieved, the roomcode is already in database
                // So its not available thats why we return false
                completion(.success(false))
            case .failure(let failure):
                completion(.success(true))
            }
        }
    }

    private func isRoomCodeAvailableSync(_ code: String) -> Bool {
        let semaphore = DispatchSemaphore(value: 0)
        var available = false

        isRoomCodeAvailable(code) { result in
            switch result {
            case .success(let exists):
                available = !exists
            case .failure:
                available = false
            }
            semaphore.signal()
        }

        semaphore.wait()
        return available
    }
}

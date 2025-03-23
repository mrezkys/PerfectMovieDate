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
    func addLovedMovie(_ id: Int, in roomCode: String, as player: PlayerType, completion: @escaping (Result<Void, Error>) -> Void)
    func checkMatchedMovie(in roomCode: String, completion: @escaping (Result<Int, Error>) -> Void)
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
    
    func addLovedMovie(
        _ id: Int,
        in roomCode: String,
        as player: PlayerType,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.getDocument(collection: "rooms", documentId: roomCode) { result in
            switch result {
            case .success(var data):
                if var playerMovies = data[player.rawValue] as? [Int] {
                    playerMovies.append(id)
                    data[player.rawValue] = playerMovies
                } else {
                    data[player.rawValue] = [id]
                }
                
                
                self.db.updateDocument(
                    collection: "rooms",
                    documentId: roomCode,
                    data: data
                ) { result in
                    switch result {
                    case .success(let success):
                        completion(.success(()))
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func createUserRoom(
        roomCode: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        print("createUserRoom()")
        let room = ["code": roomCode, "player1": [], "player2": nil] as [String : Any?]
        
        db.setDocument(
            collection: "rooms",
            documentId: roomCode,
            data: room
        ) { result in
            switch result {
            case .success(let success):
                completion(.success(()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func invalidateRoomCode(roomCode: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        db.deleteDocument(collection: "rooms", documentId: roomCode) { result in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let failure):
                completion(.failure(failure))
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
    
    func checkMatchedMovie(in roomCode: String, completion: @escaping (Result<Int, any Error>) -> Void) {
        db.getDocument(collection: "rooms", documentId: roomCode) { result in
            switch result {
            case .success(let document):
                guard let player1Movies = document["player1"] as? [Int],
                      let player2Movies = document["player2"] as? [Int] else {
                    completion(.failure(NSError(domain: "RoomRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid document structure"])))
                    return
                }
                
                // Find the first matching movie between player1 and player2
                if let matchedMovie = player1Movies.first(where: { player2Movies.contains($0) }) {
                    completion(.success(matchedMovie))
                } else {
                    completion(.success(-1)) // No match found
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

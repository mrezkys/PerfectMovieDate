//
//  FirestoreService.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 24/03/25.
//

import Foundation
import Firebase

class FirestoreService: FirestoreServiceProtocol {
    private let db = Firestore.firestore()
    
    func getDocument(
        collection: String,
        documentId: String,
        completion: @escaping (Result<[String : Any], any Error>) -> Void
    )  {
        db.collection(collection).document(documentId).getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let document = document, document.exists {
                completion(.success(document.data() ?? [:]))
            } else {
                completion(
                    .failure(
                        NSError(
                            domain: "FirestoreService",
                            code: 404,
                            userInfo: [NSLocalizedDescriptionKey: "Document not found"]
                        )
                    )
                )
            }
        }
    }
    
    func setDocument(
        collection: String,
        documentId: String,
        data: [String: Any],
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.collection(collection).document(documentId).setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func updateDocument(
        collection: String,
        documentId: String,
        data: [String: Any],
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.collection(collection).document(documentId).updateData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func deleteDocument(
        collection: String,
        documentId: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.collection(collection).document(documentId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

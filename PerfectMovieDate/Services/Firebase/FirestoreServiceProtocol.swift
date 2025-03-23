//
//  FirestoreServiceProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 24/03/25.
//

import Foundation

protocol FirestoreServiceProtocol: AnyObject {
    func getDocument(
        collection: String,
        documentId: String,
        completion: @escaping (Result<[String: Any], Error>) -> Void
    )
    
    func setDocument(
        collection: String,
        documentId: String,
        data: [String: Any],
        completion: @escaping (Result<Void, Error>) -> Void
    )
    
    func updateDocument(
        collection: String,
        documentId: String,
        data: [String: Any],
        completion: @escaping (Result<Void, Error>) -> Void
    )

    func deleteDocument(
        collection: String,
        documentId: String,
        completion: @escaping (Result<Void, Error>) -> Void
    )

}

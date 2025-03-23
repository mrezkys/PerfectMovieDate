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
}

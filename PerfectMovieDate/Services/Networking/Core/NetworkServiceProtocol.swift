//
//  NetworkServiceProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 22/06/24.
//

import Foundation

protocol NetworkServiceProtocol {
    init(logger: NetworkLoggerProtocol)
    func fetchData(
        from urlString: String,
        method: NetworkRequestType,
        headers: [String: String]?,
        requestBody: Encodable?,
        completion: @escaping (Result<Data, Error>) -> Void
    )
}

//
//  NetworkLoggerProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 28/07/24.
//

import Foundation

protocol NetworkLoggerProtocol {
    func log(request: URLRequest)
    func log(response: URLResponse?, data: Data?)
}

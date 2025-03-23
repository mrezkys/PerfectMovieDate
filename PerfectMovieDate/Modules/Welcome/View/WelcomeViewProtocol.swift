//
//  WelcomeViewProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import Foundation

protocol WelcomeViewProtocol: AnyObject {
    var presenter: WelcomePresenterProtocol? { get set }
    func displayError(_ error: Error)
}

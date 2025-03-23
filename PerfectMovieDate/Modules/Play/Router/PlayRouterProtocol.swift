//
//  PlayRouterProtocol.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//

import UIKit

protocol PlayRouterProtocol: AnyObject {
    static func createModule(with code: String, as player: PlayerType) -> UIViewController
}

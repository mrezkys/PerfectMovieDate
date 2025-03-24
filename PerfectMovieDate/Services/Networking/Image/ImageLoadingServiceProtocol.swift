//
//  ImageLoadingService.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 24/03/25.
//

import UIKit

protocol ImageLoadingServiceProtocol: AnyObject {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}



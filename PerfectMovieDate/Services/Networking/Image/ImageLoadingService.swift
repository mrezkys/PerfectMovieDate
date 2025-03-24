//
//  ImageLoadingService.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 24/03/25.
//

import UIKit

class ImageLoadingService: ImageLoadingServiceProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let image = UIImage(data: data)
            
            // Always dispatch back to the main queue for UI updates
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}

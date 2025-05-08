//
//  ImageLoader.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//
import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil, fallback: UIImage? = nil) {
        self.image = placeholder

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let mimeType = httpResponse.mimeType,
                mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data)
            else {
                DispatchQueue.main.async {
                    self.image = fallback
                }
                return
            }

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

//
//  ImageLoader.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 16/1/2564 BE.
//

import UIKit
import Foundation

class ImageLoader {
    static func loadImage(with imageView: UIImageView, for urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }.resume()
    }
}

//
//  UIImageViewExtension.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 29/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import UIKit

extension UIImageView {
    public func downloadImage(from url: String, mode: UIImageView.ContentMode = UIView.ContentMode.scaleAspectFit) {
        contentMode = mode
        
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                let mimeType = response.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                    return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}


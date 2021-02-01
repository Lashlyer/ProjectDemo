//
//  NetworkController.swift
//  ProductDemo
//
//  Created by Alvin on 2021/1/31.
//

import Foundation

import UIKit

class NetworkController {
    static let shared = NetworkController()
    
    let imageCache = NSCache<NSURL, UIImage>()
    
    func fetchImage(url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = imageCache.object(forKey: url as NSURL) {
            completionHandler(image)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
            } else {
                completionHandler(nil)
            }
        }.resume()
    }

}

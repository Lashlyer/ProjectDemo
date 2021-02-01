//
//  ProductViewModel.swift
//  ProductDemo
//
//  Created by Alvin on 2021/1/28.
//

import Foundation


class ProductViewModel {
    
    
    var productData: [OkModel]?
    
    var onRequestEnd: (() -> Void)?
    
    func prepareRequest() {
        
        guard let downloadUrl = URL(string: "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json") else { return }
                
        let request = URLRequest(url: downloadUrl)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            DispatchQueue.main.async {
                
                guard error == nil else { return }
                
                guard let datas = data else {
                    
                    return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    let classer = try decoder.decode([ProductModel].self, from: datas)
                    
                    let dataArray = (0 ..< classer.count).map { (count) -> OkModel in
                        return OkModel(data: classer[count])
                    }
                    self.productData = dataArray
                    self.onRequestEnd?()
                    
                } catch {
                    
                }
            }

        }
        
        task.resume()
    }
}

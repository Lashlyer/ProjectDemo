//
//  ProductViewModel.swift
//  ProductDemo
//
//  Created by Alvin on 2021/1/28.
//

import Foundation


class ProductViewModel {
    
    private let urlString = "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json"
    private let respository: ProductRespository
    

    init(_ respository: ProductRespository) {
        self.respository = respository
    }
    
    public func prepareRequests(completion: @escaping (_ result: DecoderResponse) -> ()) {
        respository.callProductApi(url: urlString) { response in
            switch response {
            case .data(let data):
                completion(.data(data: data))
            case .error(let error):
                completion(.error(error: error))
            }
        }
    }
    
//    var productData: [ProductModel]?
//    
//    var onRequestEnd: (() -> Void)?
    
//    func prepareRequest() {
//
//        guard let downloadUrl = URL(string: "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json") else { return }
//
//        let request = URLRequest(url: downloadUrl)
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//
//            DispatchQueue.main.async {
//
//                guard error == nil, let datas = data else { return }
//
//                do {
//
//                    let decoder = JSONDecoder()
//                    let classer = try decoder.decode([DecodableModel].self, from: datas)
//
//                    let dataArray = (0 ..< classer.count).map { (count) -> ProductModel in
//                        return ProductModel(data: classer[count])
//                    }
//
//                    self.productData = dataArray
//                    self.onRequestEnd?()
//
//                } catch {
//
//                }
//            }
//        }
//
//        task.resume()
//    }
}

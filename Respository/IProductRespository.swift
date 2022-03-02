
import Foundation

protocol IProductRespository {
    func callProductApi(url: String, completion: @escaping (_ response: DecoderResponse) -> ())
    
}

class ProductRespository: IProductRespository {
    
    private var http: HttpRequest
    
    init(_ httpRequest: HttpRequest) {
        self.http = httpRequest
    }
    
    func callProductApi(url: String, completion: @escaping (_ response: DecoderResponse) -> ()) {
        http.decodeApiResult(url: url) { status in
            DispatchQueue.main.async {
                switch status {
                case .data(let data):
                    completion(.data(data: data))
                case .error(let error):
                    completion(.error(error: error))
                }
            }
        }
    }
}

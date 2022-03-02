
import Foundation

class HttpRequest {
    
    static let shared = HttpRequest()
    
    private func get(urlString: String, completion: @escaping (_ closure: HttpStatus) -> ()) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard error == nil else {
                completion(.error(error: error.debugDescription))
                return
            }
            
            guard let datas = data else {
                completion(.error(error: "App Data is nil"))
                return
            }
            
            
            completion(.data(data: datas))
            
        }
        
        task.resume()
                
    }
    
    func decodeApiResult(url: String, completion: @escaping (_ status: DecoderResponse) -> ()) {
        get(urlString: url) { status in
            switch status {
                
            case .data(data: let data):
                do {
                    
                    let classer: [ProductModel] = try ResultDecoder.parser(data)
                    completion(.data(data: classer))
                    
                } catch {
                    completion(.error(error: "Decoder error"))
                }
                
                
            case .error(error: let error):
                completion(.error(error: error))
            }
        }
    }
}

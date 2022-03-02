//
//  Status.swift
//  ProductDemo
//
//  Created by Alvin on 2022/3/1.
//

import Foundation


enum HttpStatus {
    case data(data: Data)
    case error(error: String)
}

enum DecoderResponse {
    case data(data: [ProductModel])
    case error(error: String)
}

public enum AppError: Error, CustomStringConvertible{

    case message(String)
    case generic(Error)
    public var description: String {
        switch self {
        case let .message(message):
            return message
        case let .generic(error):
            return "網路連線異常 錯誤代碼 : \((error as NSError).localizedDescription)"
        }
    }
    public init(_ message: String) {
        self = .message(message)
        
    }

    public init(_ error: Error) {
        if let error = error as? AppError {
            self = error
        } else {
            self = .generic(error)
        }
    }

}

//
//  ProductModel.swift
//  ProductDemo
//
//  Created by Alvin on 2021/1/28.
//

import Foundation


struct ProductModel: Decodable {
    
    var description: String?
    var copyright: String?
    var title: String?
    var url: String?
    var apod_site: String?
    var date: String?
    var media_type: String?
    var hdurl: String?
    
}

struct OkModel {
    var description: String = ""
    var copyright: String = ""
    var title: String = ""
    var url: String = ""
    var apodSite: String = ""
    var date: String = ""
    var mediaType: String = ""
    var hdUrl: String = ""
}


extension OkModel {
    
    init(data: ProductModel) {
        
        self.description = data.description ?? ""
        self.copyright = data.copyright ?? ""
        self.title = data.title ?? ""
        self.url = data.url ?? ""
        self.apodSite = data.apod_site ?? ""
        self.date = data.date ?? ""
        self.mediaType = data.media_type ?? ""
        self.hdUrl = data.hdurl ?? ""
    }
}

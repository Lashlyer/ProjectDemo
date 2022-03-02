
import Foundation

struct ProductModel: Codable {
    
    var description: String = ""
    var copyright: String = ""
    var title: String = ""
    var url: String = ""
    var apodSite: String = ""
    var date: String = ""
    var mediaType: String = ""
    var hdUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        case description
        case copyright
        case title
        case url
        case apodSite = "apod_site"
        case date
        case mediaType = "media_type"
        case hdUrl
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        copyright = try container.decodeIfPresent(String.self, forKey: .copyright) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        apodSite = try container.decodeIfPresent(String.self, forKey: .apodSite) ?? ""
        date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        mediaType = try container.decodeIfPresent(String.self, forKey: .mediaType) ?? ""
        hdUrl = try container.decodeIfPresent(String.self, forKey: .hdUrl) ?? ""
    }
}

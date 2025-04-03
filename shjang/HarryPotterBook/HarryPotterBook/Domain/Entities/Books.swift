import UIKit

struct Chapter: Codable {
    let title: String
}

struct Book: Codable {
    let title: String
    let author: String
    let pages: Int
    var releaseDate: String?
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case pages
        case releaseDate = "release_date"
        case dedication
        case summary
        case wiki
        case chapters
    }
}

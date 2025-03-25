//
//  BookResponse.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/24/25.
//

import Foundation

struct BookResponse: Decodable {
    let data: [BookData]
}

struct BookData: Decodable {
    let attributes: BookInfo
}

struct BookInfo: Decodable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [ChapterInfo]
    
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
    
    func toModel() -> Book {
        return .init(
            title: title,
            author: author,
            pages: pages,
            releaseDate: releaseDate,
            dedication: dedication,
            summary: summary,
            wiki: wiki,
            chapters: chapters.map{ $0.toModel() }
        )
    }
}

struct ChapterInfo: Decodable {
    let title: String
    
    func toModel() -> Chapter {
        return .init(title: title)
    }
}

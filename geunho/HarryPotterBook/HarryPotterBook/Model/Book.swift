//
//  Book.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/25/25.
//

import Foundation

struct Book: Codable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case title, author, pages, dedication, summary, wiki, chapters
        case releaseDate = "release_date"
    }
}

struct Chapter: Codable {
    let title: String
}

struct BookWrapper: Codable {
    let attributes: Book
}

struct BookResponse: Codable {
    let data: [BookWrapper]
}


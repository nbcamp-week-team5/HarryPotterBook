//
//  Book.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/25/25.
//

import Foundation

struct BookResponse: Codable {
    let data: [BookContainer]
}

struct BookContainer: Codable {
    let attributes: Book
}

struct Book: Codable {
    let title: String
    let author: String
    let pages: Int
    let release_date: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
}

struct Chapter: Codable {
    let title: String
}

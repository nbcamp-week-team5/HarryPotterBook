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
    let release_date: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [String:String]
}

struct BookWrapper: Codable {
    let attributes: Book
}

struct BookResponse: Codable {
    let data: [BookWrapper]
}


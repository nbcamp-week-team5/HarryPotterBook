//
//  Book.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/24/25.
//

import Foundation

struct Book {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
}

struct Chapter {
    let title: String
}

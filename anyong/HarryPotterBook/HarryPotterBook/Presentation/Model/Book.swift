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
    var isExpanded: Bool
    var truncatedSummary: String?
}

extension Book {
    mutating func checkSummaryEllipsis() {
        guard summary.count >= 450 else { return }
        
        var charCount = 0
        var truncatedSummary = ""
        
        for line in summary.components(separatedBy: "\n") {
            if charCount + line.count > 450 {
                let remaining = 450 - charCount
                truncatedSummary += line.prefix(remaining) + "..."
                break
            }
            truncatedSummary += line + "\n"
            charCount += line.count + 1
        }
        
        self.truncatedSummary = truncatedSummary.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct Chapter {
    let title: String
}

//
//  BookServiceProtocol.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 4/1/25.
//

protocol BookServiceProtocol: AnyObject {
    func getBooks(completion: @escaping ([Book]) -> Void)
    func getCurrentBook(page: Int) -> Book
    func getBookSummary(page: Int) -> String
    func getBookImage(page: Int) -> String
}

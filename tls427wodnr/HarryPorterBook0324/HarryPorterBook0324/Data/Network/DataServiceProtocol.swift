//
//  DataServiceProtocol.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 4/1/25.
//

protocol DataServiceProtocol: AnyObject {
    func loadBooks(completion: @escaping (Result<[Book], Error>) -> Void)
}

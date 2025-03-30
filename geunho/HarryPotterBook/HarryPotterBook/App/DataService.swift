//
//  DataService.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/25/25.
//

import Foundation

class DataService {
    
    enum DataError: Error {
        case fileNotFound
        case parsingFailed
    }
    
    // @escaping으로 인해 completion의 클로저가 loadBooks 종료 후에도 실행 가능!
    func loadBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            // dataService.loadBooks 안에 있는 completion: { } 실행
            completion(.failure(DataError.fileNotFound))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)
            let books = bookResponse.data.map { $0.attributes }
            // dataService.loadBooks 안에 있는 completion: { } 실행
            completion(.success(books))
        } catch {
            print("🚨 JSON 파싱 에러 : \(error)")
            // dataService.loadBooks 안에 있는 completion: { } 실행
            completion(.failure(DataError.parsingFailed))
        }
    }
}

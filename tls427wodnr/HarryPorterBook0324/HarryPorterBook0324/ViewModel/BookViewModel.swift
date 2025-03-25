//
//  ViewModel.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/25/25.
//
import Foundation

class BookViewModel {
    private let dataService = DataService()
        
    private var books: [Book] = []
    
    func getBooks(completion: @escaping ([Book]) -> Void) {
        if books.isEmpty {
            dataService.loadBooks { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                    books = data
                    completion(books)
                    
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            completion(books)
        }
    }
}

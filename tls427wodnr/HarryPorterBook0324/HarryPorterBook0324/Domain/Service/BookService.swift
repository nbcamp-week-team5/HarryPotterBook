//
//  ViewModel.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/25/25.
//

class BookService: BookServiceProtocol {
    private let dataService: DataServiceProtocol
    private var books: [Book] = []
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    func getBooks(completion: @escaping ([Book]) -> Void) {
        if books.isEmpty {
            dataService.loadBooks { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.books = data
                    completion(self.books)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            completion(self.books)
        }
    }
    
    func getCurrentBook(page: Int) -> Book {
        return books[page]
    }
    
    func getBookSummary(page: Int) -> String {
        return books[page].summary
    }
    
    func getBookImage(page: Int) -> String {
        return "harrypotter\(page+1)"
    }
}

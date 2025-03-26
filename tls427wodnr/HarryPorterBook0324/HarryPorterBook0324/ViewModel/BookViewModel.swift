//
//  ViewModel.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/25/25.
//
import UIKit

class BookViewModel {
    private let pageVM: PageViewModel
    
    init(pageVM: PageViewModel) {
        self.pageVM = pageVM
    }
    
    private let dataService = DataService()
    
    private var books: [Book] = []
    
    private let bookImageResources: [ImageResource] = [.harrypotter1,.harrypotter2,.harrypotter3,.harrypotter4,.harrypotter5,.harrypotter6,.harrypotter7]
    
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
    
    func getCurrentBook() -> Book {
        return books[pageVM.getPage()]
    }
    
    func getBookSummary() -> String {
        return books[pageVM.getPage()].summary
    }
    
    func getBookImageResource() -> ImageResource {
        return bookImageResources[pageVM.getPage()]
    }
}

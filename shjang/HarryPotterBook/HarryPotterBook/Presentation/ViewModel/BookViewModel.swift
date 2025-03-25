import Foundation
import Combine

final class BookViewModel {
    var books: [Book] = []
    var selectedBook: Book? {
        didSet {
            onBookSelected?(selectedBook)
        }
    }
    
    var onBookSelected: ((Book?) -> Void)?
    
    private let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
        loadBooks()
    }
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                print("Success: \(books)")
                self.books = books.enumerated().map { index, book in
                    var updatedBook = book
                    updatedBook.seriesOrder = index + 1
                    return updatedBook
                }
                self.selectedBook = self.books.first // TMP
            case .failure(let error):
                print("Failed: \(error)")
            }
        }
    }
    
    func selectBook(_ book: Book) {
        selectedBook = book
    }
}

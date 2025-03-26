import Foundation

protocol BookViewModelDelegate: AnyObject {
    func didUpdateSelectedBook(_ viewModel: BookViewModel, _ book: Book?)
    func didFailToLoadBook(_ viewModel: BookViewModel, _ error: Error)
}

final class BookViewModel {
    weak var delegate: BookViewModelDelegate?
    private(set) var books: [Book] = []
    private(set) var selectedBook: Book? {
        didSet {
            delegate?.didUpdateSelectedBook(self, selectedBook)
        }
    }
    
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
                self.delegate?.didFailToLoadBook(self, error)
            }
        }
    }
    
    func selectBook(_ book: Book) {
        selectedBook = book
    }
}

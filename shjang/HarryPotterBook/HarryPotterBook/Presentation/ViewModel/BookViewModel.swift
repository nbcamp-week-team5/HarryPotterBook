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
        parseBook()
    }
    
    func selectBook(_ book: Book) {
        selectedBook = book
    }
    
    func parseBook() {
        dataService.parseBook{ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                self.books = self.loadData(for: books)
                self.selectedBook = self.books.first // TMP
            case .failure(let error):
                self.delegate?.didFailToLoadBook(self, error)
            }
        }
    }
    
    private func loadData(for books: [Book]) -> [Book] {
        return books.enumerated().map { index, book in
            var loadBook = self.loadReleaseDate(book)
            loadBook.seriesOrder = index + 1
            return loadBook
        }
    }
    
    private func loadReleaseDate(_ book: Book) -> Book {
        var parseBook = book
        if let releaseDate = parseBook.releaseDate {
            let formattedData = changeFormat(to: releaseDate)
            parseBook.releaseDate = formattedData
        }
        return parseBook
    }
    
    private func changeFormat(to dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid date format"
        }
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
}

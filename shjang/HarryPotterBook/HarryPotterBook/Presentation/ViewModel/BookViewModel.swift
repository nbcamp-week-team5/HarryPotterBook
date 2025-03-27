import Foundation

protocol BookViewModelDelegate: AnyObject {
    func didUpdateSelectedBook(_ viewModel: BookViewModel, _ book: Book?)
    func didFailToLoadBook(_ viewModel: BookViewModel, _ error: Error)
}

final class BookViewModel {
    private enum UserDefaultsKeys {
        static let isExpanded = "isExpanded"
    }
    
    weak var delegate: BookViewModelDelegate?
    
    private(set) var books: [Book] = []
    private(set) var selectedIndex: Int = 0
    private(set) var selectedBook: Book? {
        didSet {
            delegate?.didUpdateSelectedBook(self, selectedBook)
        }
    }
    
    var isExpanded: Bool = false
    
    private let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
        isExpanded = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isExpanded)
        parseBook()
    }
    
    func selectBook(at index: Int) {
        guard index >= 0 && index < books.count else { return }
        guard index != selectedIndex else { return }
        selectedIndex = index
        selectedBook = books[index]
        delegate?.didUpdateSelectedBook(self, selectedBook)
    }
    
    func toggleExpanded() {
        isExpanded.toggle()
        UserDefaults.standard.set(isExpanded, forKey: UserDefaultsKeys.isExpanded)
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

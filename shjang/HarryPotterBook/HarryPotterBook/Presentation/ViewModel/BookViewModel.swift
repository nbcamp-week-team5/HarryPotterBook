import Foundation

protocol BookViewModelDelegate: AnyObject {
    func didUpdateSelectedBook(_ viewModel: BookViewModel, _ book: Book?)
    func didFailToLoadBook(_ viewModel: BookViewModel, _ error: Error)
    func didFailToLoadImage(_ viewModel: BookViewModel, _ error: Error)
    func didUpdateExpandedState(_ viewModel: BookViewModel, _ index: Int)
}

final class BookViewModel {
    private enum UserDefaultsKeys {
        static let expandStates = "BookVM.expandStates"
        static let selectedIndex = "BookVM.selectedIndex"
    }
    
    weak var delegate: BookViewModelDelegate?
    
    private let dataLoader: DataLoader
    private let userDefaultService: UserDefaultsService
    
    private(set) var books: [Book] = []
    private var pageExpandStates: [Int: Bool] = [:]
    private(set) var selectedIndex: Int = 0 {
        didSet {
            userDefaultService.save(selectedIndex, forKey: UserDefaultsKeys.selectedIndex)
        }
    }
    
    private(set) var selectedBook: Book? {
        didSet {
            delegate?.didUpdateSelectedBook(self, selectedBook)
        }
    }
    
    var isExpanded: Bool {
        get { return pageExpandStates[selectedIndex] ?? false }
    }
    
    init(dataService: DataLoader, userDefaultsService: UserDefaultsStorageService) {
        self.dataLoader = dataService
        self.userDefaultService = userDefaultsService
        loadPagesStatus()
        parseBook()
    }
    
    func selectBook(at index: Int) {
        guard index >= 0 && index < books.count else { return }
        guard index != selectedIndex else { return }
        selectedIndex = index
        selectedBook = books[index]
        delegate?.didUpdateSelectedBook(self, selectedBook)
    }
    
    func toggleExpanded(for index: Int) {
        pageExpandStates[index] = !(pageExpandStates[index] ?? false)
        savePagesStatus()
        delegate?.didUpdateExpandedState(self, index)
    }
    
    // MARK: Parse Book
    func parseBook() {
        dataLoader.parseBook{ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                self.books = self.loadJSONData(for: books)
                self.selectedBook = self.books.first // TMP
            case .failure(let error):
                self.delegate?.didFailToLoadBook(self, error)
            }
        }
    }
    
    private func loadJSONData(for books: [Book]) -> [Book] {
        return books.enumerated().map { index, book in
            let loadBook = self.loadReleaseDate(book)
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
    
    // MARK: LoadImage
    
    // MARK: LoadPages
    private func loadPagesStatus() {
        // load the index first
        self.selectedIndex = userDefaultService.load(forKey: UserDefaultsKeys.selectedIndex) ?? 0
        
        if let states = userDefaultService.loadDict(forKey: UserDefaultsKeys.expandStates) as? [String: Bool] {
            pageExpandStates = states.reduce(into: [:]) { result, pair in
                if let index = Int(pair.key) {
                    result[index] = pair.value
                }
            }
        }
    }
    
    private func savePagesStatus() {
        let states = pageExpandStates.reduce(into: [:]) { result, pair in
            result[String(pair.key)] = pair.value
        }
        userDefaultService.saveDict(dict: states, forKey: UserDefaultsKeys.expandStates)
    }
}

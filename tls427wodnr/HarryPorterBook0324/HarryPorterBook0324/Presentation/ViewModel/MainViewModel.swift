//
//  MainViewModel.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/27/25.
//

class MainViewModel {
    private let pageState: PageStateProtocol
    private let bookService: BookServiceProtocol
    private let summaryService: SummaryServiceProtocol
    
    var onDataUpdated: (() -> Void)?
    
    init(pageState: PageStateProtocol = PageState(),
         bookService: BookServiceProtocol = BookService(),
         summaryService: SummaryServiceProtocol = SummaryService()) {
        self.pageState = pageState
        self.bookService = bookService
        self.summaryService = summaryService
        
        pageState.onPageUpdated = { [weak self] in
            guard let self = self else { return }
            summaryService.getSummaryState(page: pageState.getPage())
            onDataUpdated?()
        }
    }
    
    func getBooks(completion: @escaping ([Book]) -> Void) {
        bookService.getBooks(completion: completion)
    }
    
    func getCurrentBook() -> Book {
        return bookService.getCurrentBook(page: pageState.getPage())
    }
    
    func getCurrentBookImage() -> String {
        return bookService.getBookImage(page: pageState.getPage())
    }
    
    func getFormattedSummary() -> String {
        return summaryService.formatSummary(
            summary: bookService.getBookSummary(page: pageState.getPage()),
            page: pageState.getPage()
        )
    }
    
    func setPage(_ index: Int) {
        pageState.setPage(index)
    }
    
    func getPage() -> Int {
        return pageState.getPage()
    }
    
    func toggleSummaryState() {
        summaryService.toggleSummaryState(page: pageState.getPage())
    }
    
    func currentSummaryButtonTitle() -> String {
        return summaryService.currentSummaryButtonTitle(page: pageState.getPage())
    }
}

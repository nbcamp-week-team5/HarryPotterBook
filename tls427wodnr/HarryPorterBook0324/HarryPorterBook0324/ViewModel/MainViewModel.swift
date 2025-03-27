//
//  MainViewModel.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/27/25.
//

class MainViewModel {
    private let pageVM = PageViewModel()
    private let bookVM = BookViewModel()
    private let summaryVM = SummaryViewModel()
    
    var onDataUpdated: (() -> Void)?

    init() {
        pageVM.onPageUpdated = { [weak self] in
            guard let self = self else { return }
            summaryVM.getSummaryState(page: pageVM.getPage())
            onDataUpdated?()
        }
    }
    
    func getBooks(completion: @escaping ([Book]) -> Void) {
        bookVM.getBooks(completion: completion)
    }
    
    func getCurrentBook() -> Book {
        return bookVM.getCurrentBook(page: pageVM.getPage())
    }
    
    func getCurrentBookImage() -> String {
        return bookVM.getBookImage(page: pageVM.getPage())
    }
    
    func getFormattedSummary() -> String {
        return summaryVM.formatSummary(
            summary: bookVM.getBookSummary(page: pageVM.getPage()),
            page: pageVM.getPage()
        )
    }
    
    func setPage(_ index: Int) {
        pageVM.setPage(index)
    }
    
    func getPage() -> Int {
        return pageVM.getPage()
    }
    
    func toggleSummaryState() {
        summaryVM.toggleSummaryState(page: pageVM.getPage())
    }

    func currentSummaryButtonTitle() -> String {
        return summaryVM.currentSummaryButtonTitle(page: pageVM.getPage())
    }
}

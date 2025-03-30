//
//  BookController.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/30/25.
//

import Foundation

class BookController {
    
    private weak var mainView: MainViewController?
    private weak var headerView: HeaderView?
    private weak var bookInfoView: BookInfoView?
    private weak var dedicationView: DedicationView?
    private weak var summaryView: SummaryView?
    private weak var chaptersView: ChaptersView?
    
    private let dataService = DataService()
    
    var seriesCount = 0
    
    init(
        mainView: MainViewController? = nil,
        headerView: HeaderView? = nil,
        bookInfoView: BookInfoView? = nil,
        dedicationView: DedicationView? = nil,
        summaryView: SummaryView? = nil,
        chaptersView: ChaptersView? = nil
    ) {
        self.mainView = mainView
        self.headerView = headerView
        self.bookInfoView = bookInfoView
        self.dedicationView = dedicationView
        self.summaryView = summaryView
        self.chaptersView = chaptersView
    }
    
    func loadBooks() {
        dataService.loadBooks (completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                seriesCount = books.count
                headerView?.addSeriesButtons(seriesCount)
                if let firstBook = books.first {
                    headerView?.mainTitleLabel.text = firstBook.title
                    headerView?.seriesButton.setTitle("1", for: .normal)
                    bookInfoView?.bookTitle.text = firstBook.title
                    bookInfoView?.bookAuthor.text = firstBook.author
                    bookInfoView?.bookReleased.text = changeDateFormat(firstBook.releaseDate)
                    bookInfoView?.bookPages.text = String(firstBook.pages)
                    dedicationView?.dedicationLabel.text = firstBook.dedication
                    summaryView?.summaryLabel.text = firstBook.summary
                    summaryView?.detectSummaryText()
                    // chapterView 추가
                    chaptersView?.addChaptersView(firstBook)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.mainView?.showErrorAlert(error: error)
                }
                
            }
        })
    }
    
    
    
    func changeDateFormat(_ dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertedDate = dateFormatter.date(from: dateStr)
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "MMMM dd, yyyy"
        let newConvertedDate = newDateFormatter.string(from: convertedDate!)
        
        return newConvertedDate
    }
}

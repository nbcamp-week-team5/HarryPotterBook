//
//  BookController.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/30/25.
//

import Foundation
import UIKit

class BookController {
    
    static let shared = BookController()
        
    private weak var mainView: MainViewController?
    private weak var headerView: HeaderView?
    private weak var bookInfoView: BookInfoView?
    private weak var dedicationView: DedicationView?
    private weak var summaryView: SummaryView?
    private weak var chaptersView: ChaptersView?
    
    private let dataService = DataService()
    
    var seriesCount = 0
    
    private init() {}
    
    func setViews(
        mainView: MainViewController?,
        headerView: HeaderView?,
        bookInfoView: BookInfoView?,
        dedicationView: DedicationView?,
        chaptersView: ChaptersView?
    ) {
        self.mainView = mainView
        self.headerView = headerView
        self.bookInfoView = bookInfoView
        self.dedicationView = dedicationView
        self.chaptersView = chaptersView
    }
    
    func loadBooks(_ seriesNumber: Int = 1) {
        dataService.loadBooks(
            completion: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let books):
                    
                    DispatchQueue.main.async {
                        if self.mainView?.isSet == false {
                            self.seriesCount = books.count
                            self.headerView?.addSeriesButtons(self.seriesCount)
                            self.mainView?.isSet = true
                        }
                        let selectedBook = books[seriesNumber - 1]
                        self.headerView?.mainTitleLabel.text = selectedBook.title
                        
                        self.bookInfoView?.bookImageView.image = UIImage(
                            named: "harrypotter\(seriesNumber)"
                        )
                        self.bookInfoView?.bookTitle.text = selectedBook.title
                        self.bookInfoView?.bookAuthor.text = selectedBook.author
                        self.bookInfoView?.bookReleased.text = self
                            .changeDateFormat(selectedBook.releaseDate)
                        self.bookInfoView?.bookPages.text = String(selectedBook.pages)
                        
                        self.dedicationView?.dedicationLabel.text = selectedBook.dedication
                        
                        self.mainView?.updateSummaryView(seriesNumber)
                        if let summaryView = self.mainView?.summaryViews[seriesNumber] {
                            summaryView.summaryLabel.text = selectedBook.summary
                            summaryView.detectSummaryText()
                        }
                        
                        self.chaptersView?.removeChatersView()
                        self.chaptersView?.addChaptersView(selectedBook)
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
        
        guard let safeDate = convertedDate else {
            return "Invalid date format"
        }
        
        let newConvertedDate = newDateFormatter.string(from: safeDate)
        
        return newConvertedDate
    }
}

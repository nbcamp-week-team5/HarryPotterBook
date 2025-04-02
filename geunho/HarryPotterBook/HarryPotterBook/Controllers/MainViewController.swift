//
//  ViewController.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/25/25.
//

import UIKit
import SnapKit


final class MainViewController: UIViewController, HeaderViewDelegate {
    
    lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.delegate = self
        return view
    }()
    private let bookInfoView = BookInfoView()
    private let dedicationView = DedicationView()
    private lazy var summaryView = SummaryView(frame: .zero, seriesNumber: 1)
    private var currentSummaryView: SummaryView?
    private let chaptersView = ChaptersView()
    
    private let dataService = DataService()
    
    var seriesCount = 0
    private var dataLoaded = false
    
    // ScrollView
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    private lazy var scrollContentsVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 24
        return stackView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadBooks()
        
        configureLayout()
        
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        
        [headerView, scrollView].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(scrollContentsVStack)
        
        [bookInfoView, dedicationView, summaryView, chaptersView].forEach {
            scrollContentsVStack.addArrangedSubview($0)
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        scrollContentsVStack.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.width
                .equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func loadBooks(_ seriesNumber: Int = 1) {
        dataService.loadBooks(
            completion: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let books):
                    DispatchQueue.main.async {
                        // 첫 로드시만 seriesButtons 추가
                        if !self.dataLoaded {
                            self.seriesCount = books.count
                            self.headerView.addSeriesButtons(self.seriesCount)
                            self.dataLoaded = true
                        }
                        let selectedBook = books[seriesNumber - 1]
                        self.headerView.mainTitleLabel.text = selectedBook.title
                        
                        self.bookInfoView.bookImageView.image = UIImage(
                            named: "harrypotter\(seriesNumber)"
                        )
                        self.bookInfoView.bookTitle.text = selectedBook.title
                        self.bookInfoView.bookAuthor.text = selectedBook.author
                        self.bookInfoView.bookReleased.text = self
                            .changeDateFormat(selectedBook.releaseDate)
                        self.bookInfoView.bookPages.text = String(selectedBook.pages)
                        
                        self.dedicationView.dedicationLabel.text = selectedBook.dedication
                        
                        self.updateSummaryView(
                            seriesNumber,
                            with: selectedBook.summary
                        )
                        
                        self.chaptersView.removeChatersView()
                        self.chaptersView.addChaptersView(selectedBook)
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showErrorAlert(error: error)
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
    
    func updateSummaryView(_ seriesNumber: Int, with summaryText: String) {
        summaryView.updateSeriesNumber(seriesNumber)
        summaryView.summaryLabel.text = summaryText
        summaryView.detectSummaryText()
    }
    
    func showErrorAlert(error: Error) {
        print("에러: \(error)")
        let alert = UIAlertController(
            title: "파일을 불러오지 못했습니다!",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadSelectedSeries(_ headerView: HeaderView, didSelectSeries seriesNumber: Int) {
        loadBooks(seriesNumber)
    }
}

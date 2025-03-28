//
//  ViewController.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/25/25.
//

import UIKit
import SnapKit


final class MainViewController: UIViewController {
    
    // SubViews
    private let headerView = HeaderView()
    private let bookInfoView = BookInfoView()
    private let dedicationView = DedicationView()
    private let summaryView = SummaryView()
    private let chaptersView = ChaptersView()
    
    private let dataService = DataService()
    
    
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
        
        summaryView.detectSummaryText()
        
        configureLayout()
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        
        [headerView, scrollView].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(scrollContentsVStack)
        
        [bookInfoView, dedicationView, summaryView, summaryView.summaryButtonStackView, chaptersView].forEach {
            scrollContentsVStack.addArrangedSubview($0)
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        
        scrollContentsVStack.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.seriesButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    // MARK: - Other Functions
    func loadBooks() {
        dataService.loadBooks (completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                if let firstBook = books.first {
                    headerView.mainTitleLabel.text = firstBook.title
                    headerView.seriesButton.setTitle("1", for: .normal)
                    bookInfoView.bookTitle.text = firstBook.title
                    bookInfoView.bookAuthor.text = firstBook.author
                    bookInfoView.bookReleased.text = changeDateFormat(firstBook.releaseDate)
                    bookInfoView.bookPages.text = String(firstBook.pages)
                    dedicationView.dedicationLabel.text = firstBook.dedication
                    summaryView.summaryLabel.text = firstBook.summary
                    
                    chaptersView.addChaptersView(firstBook)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showErrorAlert(error: error)
                }
                
            }
        })
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

#Preview {
    MainViewController()
}

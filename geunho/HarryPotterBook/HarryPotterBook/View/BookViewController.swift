//
//  ViewController.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/25/25.
//

import UIKit
import SnapKit

final class BookViewController: UIViewController {
    
    private let dataService = DataService()
    
    private var isFolded = true
    private var tempString = ""

    
    // MARK: - Main Title
    private lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Harry Potter"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var seriesButton: UIButton = {
        var button = UIButton()
        button.setTitle("1", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    
    // MARK: - Book Primary Info
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
        stackView.alignment = .firstBaseline
        stackView.spacing = 8
        return stackView
    }()
    
    // 메인 HStack
    private lazy var bookHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "harrypotter1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // 책 상세 정보 VStack
    private lazy var bookVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    private lazy var bookTitle: UILabel = {
        let label = UILabel()
        label.text = "Harry Potter"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    // Author HStack
    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    private lazy var author: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private lazy var bookAuthor: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    // Released HStack
    private lazy var releasedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    private lazy var released: UILabel = {
        let label = UILabel()
        label.text = "Released"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    private lazy var bookReleased: UILabel = {
        let label = UILabel()
        label.text = "Released Date"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    // Pages HStack
    private lazy var pagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    private lazy var pages: UILabel = {
        let label = UILabel()
        label.text = "Pages"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    private lazy var bookPages: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Dedication, Summary
    // Dedication
    private lazy var dedicationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    private lazy var dedication: UILabel = {
        let label = UILabel()
        label.text = "Dedication"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    private lazy var dedicationLabel: UILabel = {
        let label = UILabel()
        label.text = "Dedication..."
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    // Summary
    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    private lazy var summary: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    private lazy var summaryLabel: UILabel = {
        var label = UILabel()
        label.text = "Summary..."
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    private lazy var summaryButton: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.addTarget(
            self,
            action: #selector(summaryButtonClicked),
            for: .touchUpInside
        )
        button.isHidden = true
        return button
    }()
    private lazy var summaryButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Chapters
    private lazy var chapterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    private lazy var chapters: UILabel = {
        let label = UILabel()
        label.text = "Chapters"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    
    // MARK: UI
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
        
        detectSummaryText()
        
        configureViews()
        configureLayout()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        
        [mainTitleLabel, seriesButton, scrollView].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(scrollContentsVStack)
        
        // Scroll View
        [bookHStackView, dedicationStackView, summaryStackView, summaryButtonStackView, chapterStackView].forEach {
            scrollContentsVStack.addArrangedSubview($0)
        }
        
        [bookImageView, bookVStackView].forEach {
            bookHStackView.addArrangedSubview($0)
        }
        
        [bookTitle, authorStackView, releasedStackView, pagesStackView].forEach {
            bookVStackView.addArrangedSubview($0)
        }
        
        [author, bookAuthor].forEach {
            authorStackView.addArrangedSubview($0)
        }
        
        [released, bookReleased].forEach {
            releasedStackView.addArrangedSubview($0)
        }
        
        [pages, bookPages].forEach {
            pagesStackView.addArrangedSubview($0)
        }
        
        [dedication, dedicationLabel].forEach {
            dedicationStackView.addArrangedSubview($0)
        }
        
        [summary, summaryLabel].forEach {
            summaryStackView.addArrangedSubview($0)
        }
        
        summaryButtonStackView.addArrangedSubview(summaryButton)
    }
    
    private func configureLayout() {
        
        mainTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }
        
        seriesButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(16)
        }
        
        bookHStackView.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(70)
        }
        
        bookImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(150)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
        }
        
        dedicationStackView.snp.makeConstraints { make in
            make.top.equalTo(bookHStackView.snp.bottom).offset(24)
        }
        
        summaryStackView.snp.makeConstraints { make in
            make.top.equalTo(dedicationStackView.snp.bottom).offset(24)
        }
        
        summaryButtonStackView.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(20)
            
            // trailing 정렬 완료
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
        
        chapterStackView.snp.makeConstraints { make in
            make.top.equalTo(summaryStackView.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(seriesButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        scrollContentsVStack.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.width.equalToSuperview()
        }
    }
    
    // MARK: - Other Functions
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                if let firstBook = books.first {
                    self.mainTitleLabel.text = firstBook.title
                    self.seriesButton.setTitle("1", for: .normal)
                    self.bookTitle.text = firstBook.title
                    self.bookAuthor.text = firstBook.author
                    self.bookReleased.text = changeDateFormat(firstBook.releaseDate)
                    self.bookPages.text = String(firstBook.pages)
                    self.dedicationLabel.text = firstBook.dedication
                    self.summaryLabel.text = firstBook.summary
                    
                    // Chapters View
                    chapterStackView.addArrangedSubview(chapters)
                    for chapter in firstBook.chapters{
                        lazy var chaptersLabel: UILabel = {
                            let label = UILabel()
                            label.text = "1. Chapter"
                            label.font = .systemFont(ofSize: 14)
                            label.numberOfLines = 0
                            label.textColor = .darkGray
                            return label
                        }()
                        chaptersLabel.text = chapter.title
                        chapterStackView.addArrangedSubview(chaptersLabel)
                    }
                }
            case .failure(let error):
                print("에러: \(error)")
            }
        }
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
    
    func truncateSummaryText() {
        
        
        if self.isFolded {
            tempString = summaryLabel.text!
            let startIndex = summaryLabel.text!.index(summaryLabel.text!.startIndex, offsetBy: 450)
            let endIndex = summaryLabel.text!.endIndex
            
            summaryLabel.text?
                .replaceSubrange(startIndex..<endIndex, with: "...")
        }
        else {
            summaryLabel.text = tempString
        }
        
        
    }
    
    func detectSummaryText() {
        if summaryLabel.text!.count >= 450 {
            summaryButton.isHidden = false
            tempString = summaryLabel.text!
            truncateSummaryText()
        }
    }
    
    @objc func summaryButtonClicked() {
        
        if !self.isFolded {
            summaryButton.setTitle("더보기", for: .normal)
            self.isFolded = !self.isFolded
            truncateSummaryText()
        } else {
            summaryButton.setTitle("접기", for: .normal)
            self.isFolded = !self.isFolded
            truncateSummaryText()
        }
        
        
        UserDefaults.standard.set(isFolded, forKey: "summaryButtonState")
    }
    
}

#Preview {
    BookViewController()
}

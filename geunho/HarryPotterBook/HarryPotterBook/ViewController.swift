//
//  ViewController.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/25/25.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    private let dataService = DataService()
    
    // MARK: - 제목 영역
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Harry Potter"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var seriesOrder: UIButton = {
        let button = UIButton()
        button.setTitle("1", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        //        button.layer.cornerRadius = button.frame.width / 2
        button.layer.cornerRadius = 20
        return button
    }()
    
    
    // MARK: - 책 정보 영역
    // ScrollView
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    private lazy var scrollContentsVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
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
        stackView.alignment = .leading
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
        stackView.alignment = .leading
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
        let label = UILabel()
        label.text = "Summary..."
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: - Chapter
    private lazy var chapterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
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
//    private lazy var chaptersLabel: UILabel = {
//        let label = UILabel()
//        label.text = "1. Chapter"
//        label.font = .systemFont(ofSize: 14)
//        label.numberOfLines = 0
//        label.textColor = .darkGray
//        return label
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
        
        configureLayout()
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        
        [titleLabel, seriesOrder, scrollView].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(scrollContentsVStack)
        
        // Scroll View
        [bookHStackView, dedicationStackView, summaryStackView, chapterStackView].forEach {
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
        
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }
        
        seriesOrder.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        bookHStackView.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(70)
//            make.top.equalTo(seriesOrder.snp.bottom).offset(16)
        }
        
        bookImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(150)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
        }
        
        dedicationStackView.snp.makeConstraints { make in
            make.top.equalTo(bookHStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        summaryStackView.snp.makeConstraints { make in
            make.top.equalTo(dedicationStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        chapterStackView.snp.makeConstraints { make in
            make.top.equalTo(summaryStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(seriesOrder.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollContentsVStack.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                if let firstBook = books.first {
                    self.titleLabel.text = firstBook.title
                    self.seriesOrder.setTitle("1", for: .normal)
                    self.bookTitle.text = firstBook.title
                    self.bookAuthor.text = firstBook.author
                    self.bookReleased.text = changeDateFormat(firstBook.releaseDate)
                    self.bookPages.text = String(firstBook.pages)
                    self.dedicationLabel.text = firstBook.dedication
                    self.summaryLabel.text = firstBook.summary
                    
                    // Chapter
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
}

#Preview {
    ViewController()
}

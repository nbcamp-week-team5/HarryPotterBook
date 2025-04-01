//
//  MainView.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/26/25.
//

import UIKit

class MainView: UIView {
    let bookInfoView = BookInfoView()
    let dedicationView = DedicationView()
    let summaryView = SummaryView()
    let chapterView = ChapterView()
    
    private let verticalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        //setupLayout()
        setupLayoutWithSnapKit()
        summaryView.setupSummaryButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(verticalScrollView)
        verticalScrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(bookInfoView)
        contentStackView.addArrangedSubview(dedicationView)
        contentStackView.addArrangedSubview(summaryView)
        contentStackView.addArrangedSubview(chapterView)
        
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
//    private func setupLayout() {
//        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
//        contentStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            chapterView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 24),
//            
//            verticalScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            verticalScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            verticalScrollView.topAnchor.constraint(equalTo: topAnchor),
//            verticalScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            
//            contentStackView.topAnchor.constraint(equalTo: verticalScrollView.contentLayoutGuide.topAnchor),
//            contentStackView.bottomAnchor.constraint(equalTo: verticalScrollView.contentLayoutGuide.bottomAnchor),
//            contentStackView.leadingAnchor.constraint(equalTo: verticalScrollView.contentLayoutGuide.leadingAnchor),
//            contentStackView.trailingAnchor.constraint(equalTo: verticalScrollView.contentLayoutGuide.trailingAnchor),
//            contentStackView.widthAnchor.constraint(equalTo: verticalScrollView.frameLayoutGuide.widthAnchor),
//        ])
//    }
    
    private func setupLayoutWithSnapKit() {
        chapterView.snp.makeConstraints {
            $0.top.equalTo(summaryView.snp.bottom).offset(24)
        }

        verticalScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentStackView.snp.makeConstraints {
            $0.edges.equalTo(verticalScrollView.contentLayoutGuide)
            $0.width.equalTo(verticalScrollView.frameLayoutGuide.snp.width)
        }
    }
    
    func configure(book: Book, bookImage: UIImage, formattedSummary: String) {
        summaryView.setupSummaryButton()
        
        bookInfoView.configure(
            bookTitle: book.title,
            bookImage: bookImage,
            bookAuthor: book.author,
            bookReleaseDate: book.release_date,
            bookPage: String(book.pages)
        )
        
        dedicationView.configure(book.dedication)
        
        summaryView.configure(summaryCount: book.summary.count, formattedSummary: formattedSummary)
        
        chapterView.configure(book)
    }
    
    func setSummaryViewDelegate(_ delegate: SummaryViewDelegate) {
        summaryView.delegate = delegate
    }
}

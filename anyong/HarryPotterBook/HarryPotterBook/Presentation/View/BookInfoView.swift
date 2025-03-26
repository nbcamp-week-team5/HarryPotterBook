//
//  BookInfoView.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/24/25.
//

import UIKit

import Then
import SnapKit

final class BookInfoView: UIView {
    private let titleLabel = UILabel()
    private let orderButton = UIButton(type: .system)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let bookInfoSection = BookInfoSection()
    private let bookDeatilInfoSection = BookDetailInfoSection()
    private let bookChapterSection = BookChapterSection()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        self.do {
            $0.backgroundColor = .white
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        orderButton.do {
            $0.titleLabel?.font = .systemFont(ofSize: 16)
            $0.titleLabel?.textAlignment = .center
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemBlue
            $0.layer.cornerRadius = 20
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.alwaysBounceVertical = true
        }
    }
    
    private func setUI() {
        addSubViews(titleLabel, orderButton, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews(bookInfoSection, bookDeatilInfoSection, bookChapterSection)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        orderButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(orderButton.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        bookInfoSection.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        bookDeatilInfoSection.snp.makeConstraints {
            $0.top.equalTo(bookInfoSection.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        bookChapterSection.snp.makeConstraints {
            $0.top.equalTo(bookDeatilInfoSection.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}

extension BookInfoView {
    func configure(_ book: Book, _ num: Int) {
        titleLabel.text = book.title
        orderButton.setTitle("\(num)", for: .normal)
        bookInfoSection.configure(book, num)
        bookDeatilInfoSection.configure(book)
        bookChapterSection.configure(book)
    }
}

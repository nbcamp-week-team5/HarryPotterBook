//
//  BookInfoCellView.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/25/25.
//

import UIKit

import SnapKit
import Then

final class BookInfoCellView: UIView {
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorTitleLabel = UILabel()
    private let authorLabel = UILabel()
    private let releasedTitleLabel = UILabel()
    private let releasedLabel = UILabel()
    private let pagesTitleLabel = UILabel()
    private let pagesLabel = UILabel()
    
    private let imageStackView = UIStackView()
    private let titleStackView = UIStackView()
    private let authorStackView = UIStackView()
    private let releasedStackView = UIStackView()
    private let pagesStackView = UIStackView()
    
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
        posterImageView.do {
            $0.contentMode = .scaleToFill
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 20, weight: .bold)
            $0.textColor = .black
            $0.numberOfLines = 2
        }
        
        authorTitleLabel.do {
            $0.text = "Author"
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textColor = .black
        }
        
        authorLabel.do {
            $0.font = .systemFont(ofSize: 18)
            $0.textColor = .darkGray
        }
        
        releasedTitleLabel.do {
            $0.text = "Released"
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .black
        }
        
        releasedLabel.do {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .gray
        }
        
        pagesTitleLabel.do {
            $0.text = "Pages"
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .black
        }
        
        pagesLabel.do {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .gray
        }
        
        imageStackView.do {
            $0.axis = .horizontal
            $0.spacing = 15
            $0.alignment = .top
        }
        
        titleStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .leading
        }
        
        authorStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .leading
        }
        
        releasedStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .leading
        }
        
        pagesStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .center
        }
    }
    
    private func setUI() {
        authorStackView.addArrangedSubViews(authorTitleLabel, authorLabel)
        releasedStackView.addArrangedSubViews(releasedTitleLabel, releasedLabel)
        pagesStackView.addArrangedSubViews(pagesTitleLabel, pagesLabel)
        titleStackView.addArrangedSubViews(
            titleLabel,
            authorStackView,
            releasedStackView,
            pagesStackView
        )
        imageStackView.addArrangedSubViews(posterImageView, titleStackView)
        addSubview(imageStackView)
    }
    
    private func setLayout() {
        posterImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
        }
        
        imageStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension BookInfoCellView {
    func configure(_ book: Book, _ num: Int) {
        posterImageView.image = UIImage(named: "harrypotter\(num)")
        titleLabel.text = book.title
        authorLabel.text = book.author
        releasedLabel.text = book.releaseDate
        pagesLabel.text = "\(book.pages)"
    }
}

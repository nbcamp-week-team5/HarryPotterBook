//
//  BookDetailView.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/26/25.
//

import UIKit
import SnapKit

class BookInfoView: UIView {
    private lazy var bookInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bookImage,bookDetailStackView])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private lazy var authorInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [authorTitle,bookAuthor])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private lazy var releaseInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [releasedTitle,bookReleaseDate])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private lazy var pageInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pageTitle,bookPage])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private lazy var bookDetailStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bookTitle,authorInfoStackView,releaseInfoStackView,pageInfoStackView])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    private let bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bookTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let authorTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Author"
        return label
    }()
    
    private let bookAuthor: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    private let releasedTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Released"
        return label
    }()
    
    private let bookReleaseDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    private let pageTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Pages"
        return label
    }()
    
    private let bookPage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayoutWithSnapKit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(bookInfoStackView)
    }
    
    private func setupLayoutWithSnapKit() {
        bookImage.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        bookInfoStackView.snp.makeConstraints { 
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(bookTitle: String, bookImage: UIImage, bookAuthor: String, bookReleaseDate: String, bookPage: String) {
        self.bookTitle.text = bookTitle
        self.bookImage.image = bookImage
        self.bookAuthor.text = bookAuthor
        self.bookReleaseDate.text = bookReleaseDate
        self.bookPage.text = bookPage
    }
}

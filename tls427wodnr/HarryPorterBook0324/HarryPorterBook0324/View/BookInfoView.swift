//
//  BookDetailView.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/26/25.
//

import UIKit

class BookInfoView: UIView {

    private let bookInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private let authorInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private let releaseInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private let pageInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private let bookDetailStackView: UIStackView = {
        let stack = UIStackView()
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
    
    private func setupViews() {
        authorInfoStackView.addArrangedSubview(authorTitle)
        authorInfoStackView.addArrangedSubview(bookAuthor)
        
        releaseInfoStackView.addArrangedSubview(releasedTitle)
        releaseInfoStackView.addArrangedSubview(bookReleaseDate)
        
        pageInfoStackView.addArrangedSubview(pageTitle)
        pageInfoStackView.addArrangedSubview(bookPage)
        
        bookDetailStackView.addArrangedSubview(bookTitle)
        bookDetailStackView.addArrangedSubview(authorInfoStackView)
        bookDetailStackView.addArrangedSubview(releaseInfoStackView)
        bookDetailStackView.addArrangedSubview(pageInfoStackView)
        
        bookInfoStackView.addArrangedSubview(bookImage)
        bookInfoStackView.addArrangedSubview(bookDetailStackView)
    }

}

//
//  InfoView.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/28/25.
//

import UIKit
import SnapKit

class BookInfoView: UIView {
    
    // 메인 HStack
    private lazy var bookHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    // 이미지
    lazy var bookImageView: UIImageView = {
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
    
    // Title
    lazy var bookTitle: UILabel = {
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
    lazy var bookAuthor: UILabel = {
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
    lazy var bookReleased: UILabel = {
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
    lazy var bookPages: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        
        self.addSubview(bookHStackView)
        
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
        
        bookHStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        bookVStackView.snp.makeConstraints { _ in
           
        }
                
        bookImageView.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(100)
            make.height.equalTo(150)
            make.leading.equalToSuperview()
        }
    }
}

//
//  ViewController.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/24/25.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = BookViewModel()
    
    private var page = 1 {
        didSet {
            bindData()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let pageButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
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
        imageView.image = UIImage(resource: .harrypotter1)
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
    
    private let dedicationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private let dedicationTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Dedication"
        return label
    }()
    
    private let bookDedication: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let summaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private let summaryTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Summary"
        return label
    }()
    
    private let bookSummary: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let verticalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
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
    
    private let chapterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private let chapterTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Chapters"
        return label
    }()
    
    private let chapterListView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        bindData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        pageButton.setTitle("\(page)", for: .normal)
        pageButton.addTarget(self, action: #selector(clickPageButton), for: .touchUpInside)
      
        view.addSubview(headerStackView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(pageButton)
        
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
        
        dedicationStackView.addArrangedSubview(dedicationTitle)
        dedicationStackView.addArrangedSubview(bookDedication)
        
        summaryStackView.addArrangedSubview(summaryTitle)
        summaryStackView.addArrangedSubview(bookSummary)
        
        chapterStackView.addArrangedSubview(chapterTitle)
        chapterStackView.addArrangedSubview(chapterListView)
                
        view.addSubview(verticalScrollView)
        verticalScrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(bookInfoStackView)
        contentStackView.addArrangedSubview(dedicationStackView)
        contentStackView.addArrangedSubview(summaryStackView)
        contentStackView.addArrangedSubview(chapterStackView)
        
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func setupLayout() {
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        pageButton.translatesAutoresizingMaskIntoConstraints = false
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pageButton.widthAnchor.constraint(equalToConstant: 32),
            pageButton.heightAnchor.constraint(equalToConstant: 32),
            
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            bookImage.widthAnchor.constraint(equalToConstant: 100),
            bookImage.heightAnchor.constraint(equalToConstant: 150),
            
            chapterStackView.topAnchor.constraint(equalTo: summaryStackView.bottomAnchor, constant: 24),
            
            verticalScrollView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor)
        ])
    }
    
    private func bindData() {
        viewModel.getBooks { [weak self] books in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let book = books[self.page - 1]
                self.titleLabel.text = book.title
                self.bookTitle.text = book.title
                self.bookAuthor.text = book.author
                self.bookReleaseDate.text = book.release_date
                self.bookPage.text = String(book.pages)
                self.bookDedication.text = book.dedication
                self.bookSummary.text = book.summary
                book.chapters.enumerated().forEach { (_, chapter) in
                    let label = UILabel()
                    label.font = .systemFont(ofSize: 14)
                    label.textColor = .darkGray
                    label.numberOfLines = 0
                    label.text = "\(chapter.title)"
                    self.chapterListView.addArrangedSubview(label)
                }
            }
        }
    }
    
    @objc func clickPageButton() {
        guard let buttonTitle = pageButton.title(for: .normal),
              let pageNumber = Int(buttonTitle) else {
            return
        }
        page = pageNumber
    }
}


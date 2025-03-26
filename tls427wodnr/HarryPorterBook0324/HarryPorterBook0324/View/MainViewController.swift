//
//  ViewController.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/24/25.
//

import UIKit

class MainViewController: UIViewController {
    private let pageVM = PageViewModel()
    private lazy var bookVM = BookViewModel(pageVM: pageVM)
    private lazy var summaryVM = SummaryViewModel(pageVM: pageVM, bookVM: bookVM)
    
    private let headerView = HeaderView()
    
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
    
    private let summaryButtonWrapper: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.distribution = .fill
        return stackView
    }()
    
    private let spacer = UIView()
        
    private lazy var summaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(clickSummaryButton), for: .touchUpInside)
        return button
    }()
    
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
        pageVM.onPageUpdated = { [weak self] in
            self?.summaryVM.getSummaryState()
            self?.bindData()
            self?.headerView.setPageButtonColor()
        }
        headerView.delegate = self
        setupViews()
        setupSummaryButton()
        setupLayout()
        bindData()
        headerView.setPageButtonColor()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        
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
        
        summaryButtonWrapper.addArrangedSubview(spacer)
        summaryButtonWrapper.addArrangedSubview(summaryButton)
        summaryStackView.addArrangedSubview(summaryButtonWrapper)
        
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
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            summaryButtonWrapper.widthAnchor.constraint(equalTo: summaryStackView.widthAnchor),
            
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            bookImage.widthAnchor.constraint(equalToConstant: 100),
            bookImage.heightAnchor.constraint(equalToConstant: 150),
            
            chapterStackView.topAnchor.constraint(equalTo: summaryStackView.bottomAnchor, constant: 24),
            
            verticalScrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor),
        ])
    }
    
    private func setupSummaryButton() {
        self.summaryButton.setTitle(summaryVM.currentSummaryButtonTitle(), for: .normal)
    }
    
    @objc func clickSummaryButton() {
        summaryVM.toggleSummaryState()
        bindData()
    }
    
    private func bindData() {
        bookVM.getBooks { [weak self] books in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setupSummaryButton()
                let book = books[self.pageVM.getPage()]
                self.headerView.configure(book.title)
                self.bookTitle.text = book.title
                self.bookImage.image = UIImage(resource: self.bookVM.getBookImageResource())
                self.bookAuthor.text = book.author
                self.bookReleaseDate.text = book.release_date
                self.bookPage.text = String(book.pages)
                self.bookDedication.text = book.dedication
                self.summaryButton.isHidden = book.summary.count < 450
                self.bookSummary.text = self.summaryVM.formatSummary()
                self.chapterListView.arrangedSubviews.forEach { $0.removeFromSuperview() }
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
}

extension MainViewController: HeaderViewDelegate {
    func didTapPageButton(at index: Int) {
        pageVM.setPage(index)
    }

    func currentPage(in headerView: HeaderView) -> Int {
        return pageVM.getPage()
    }
}


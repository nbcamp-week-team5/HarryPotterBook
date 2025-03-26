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
    private let bookInfoView = BookInfoView()
    private let dedicationView = DedicationView()
    private let summaryView = SummaryView()
    
    // MARK: Chapters Component
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
        
        summaryView.delegate = self
        summaryView.setupSummaryButton()
        setupLayout()
        bindData()
        headerView.setPageButtonColor()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        
        chapterStackView.addArrangedSubview(chapterTitle)
        chapterStackView.addArrangedSubview(chapterListView)
                
        view.addSubview(verticalScrollView)
        verticalScrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(bookInfoView)
        contentStackView.addArrangedSubview(dedicationView)
        contentStackView.addArrangedSubview(summaryView)
        contentStackView.addArrangedSubview(chapterStackView)
        
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func setupLayout() {
        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            chapterStackView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 24),
            
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
    
    private func bindData() {
        bookVM.getBooks { [weak self] books in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.summaryView.setupSummaryButton()
                let book = books[self.pageVM.getPage()]
                self.headerView.configure(book.title)
                
                self.bookInfoView.configure(bookTitle: book.title, bookImage: UIImage(resource: self.bookVM.getBookImageResource()), bookAuthor: book.author, bookReleaseDate: book.release_date, bookPage: String(book.pages))
                
                self.dedicationView.configure(book.dedication)
                
                self.summaryView.configure(summaryCount: book.summary.count, formattedSummary: self.summaryVM.formatSummary())
                
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

    func currentPage() -> Int {
        return pageVM.getPage()
    }
}

extension MainViewController: SummaryViewDelegate {
    func getCurrentSummaryButtonTitle() -> String {
        summaryVM.currentSummaryButtonTitle()
    }
    
    func didTapSummaryButton() {
        summaryVM.toggleSummaryState()
        bindData()
    }
}

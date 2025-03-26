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
    
    // MARK: SummaryView Component
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
        setupSummaryButton()
        setupLayout()
        bindData()
        headerView.setPageButtonColor()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        
        summaryStackView.addArrangedSubview(summaryTitle)
        summaryStackView.addArrangedSubview(bookSummary)
        
        summaryButtonWrapper.addArrangedSubview(spacer)
        summaryButtonWrapper.addArrangedSubview(summaryButton)
        summaryStackView.addArrangedSubview(summaryButtonWrapper)
        
        chapterStackView.addArrangedSubview(chapterTitle)
        chapterStackView.addArrangedSubview(chapterListView)
                
        view.addSubview(verticalScrollView)
        verticalScrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(bookInfoView)
        contentStackView.addArrangedSubview(dedicationView)
        contentStackView.addArrangedSubview(summaryStackView)
        contentStackView.addArrangedSubview(chapterStackView)
        
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func setupLayout() {
        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            summaryButtonWrapper.widthAnchor.constraint(equalTo: summaryStackView.widthAnchor),
            
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
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
                
                self.bookInfoView.configure(bookTitle: book.title, bookImage: UIImage(resource: self.bookVM.getBookImageResource()), bookAuthor: book.author, bookReleaseDate: book.release_date, bookPage: String(book.pages))
                
                self.dedicationView.configure(book.dedication)
                
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


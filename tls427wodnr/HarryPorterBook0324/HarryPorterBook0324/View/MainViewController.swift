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
    private let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageVM.onPageUpdated = { [weak self] in
            self?.summaryVM.getSummaryState()
            self?.bindData()
            self?.headerView.setPageButtonColor()
        }
        headerView.delegate = self
        headerView.setPageButtonColor()
        mainView.setSummaryViewDelegate(self)
        setupViews()
        setupLayout()
        bindData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(mainView)
    }
    
    private func setupLayout() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            mainView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func bindData() {
        bookVM.getBooks { [weak self] books in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let book = self.bookVM.getCurrentBook()
                self.headerView.configure(book.title)
                self.mainView.configure(
                    book: book,
                    bookImage: UIImage(resource: self.bookVM.getBookImageResource()),
                    formattedSummary: self.summaryVM.formatSummary()
                )
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

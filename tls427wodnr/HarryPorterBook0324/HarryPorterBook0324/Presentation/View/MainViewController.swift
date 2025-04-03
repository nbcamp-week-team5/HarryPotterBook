//
//  ViewController.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/24/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let viewModel = MainViewModel(pageState: PageState(), bookService: BookService(dataService: DataService()), summaryService: SummaryService())

    private let headerView = HeaderView()
    private let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }
            bindData()
            headerView.setPageButtonColor()
        }
        headerView.delegate = self
        headerView.setPageButtonColor()
        mainView.setSummaryViewDelegate(self)
        setupViews()
        setupLayoutWithSnapKit()
        bindData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(mainView)
    }
    
    private func setupLayoutWithSnapKit() {
        headerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        mainView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func bindData() {
        viewModel.getBooks { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let book = self.viewModel.getCurrentBook()
                let imageName = self.viewModel.getCurrentBookImage()
                let image = UIImage(named: imageName) ?? UIImage()
                let formattedSummary = self.viewModel.getFormattedSummary()
                self.headerView.configureTitleLabel(book.title)
                self.mainView.configure(
                    book: book,
                    bookImage: image,
                    formattedSummary: formattedSummary
                )
            }
        }
    }
}

extension MainViewController: HeaderViewDelegate {
    func didTapPageButton(at index: Int) {
        viewModel.setPage(index)
    }
    
    func currentPage() -> Int {
        return viewModel.getPage()
    }
}

extension MainViewController: SummaryViewDelegate {
    func getCurrentSummaryButtonTitle() -> String {
        return viewModel.currentSummaryButtonTitle()
    }
    
    func didTapSummaryButton() {
        viewModel.toggleSummaryState()
        bindData()
    }
}

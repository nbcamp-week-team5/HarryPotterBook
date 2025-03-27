//
//  ViewController.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/24/25.
//

import UIKit

class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()

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
        viewModel.getBooks { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let book = self.viewModel.getCurrentBook()
                let imageName = self.viewModel.getCurrentBookImage()
                let image = UIImage(named: imageName) ?? UIImage()
                let formattedSummary = self.viewModel.getFormattedSummary()
                self.headerView.configure(book.title)
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

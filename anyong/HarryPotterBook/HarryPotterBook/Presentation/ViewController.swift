//
//  ViewController.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/24/25.
//

import UIKit

final class ViewController: UIViewController {
    private let rootView = BookInfoView()
    private let dataService = DataService()
    private let userDefaultService = UserDefaultService()
    private let alert = UIAlertController(title: "알림", message: "정보를 불러오는데 실패했습니다", preferredStyle: .alert)
    
    private var currentIndex = 0
    private var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
    }
    
    override func loadView() {
        view = rootView
        rootView.delegate = self
        rootView.bookDetailInfoSection.delegate = self
    }
}

extension ViewController {
    private func showAlert() {
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    private func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                self.books = success
                
                if !self.books.isEmpty {
                    let isExpended = self.userDefaultService.get(0)
                    self.books[0].isExpanded = isExpended
                    self.rootView.configure(books[0], 1, books.count)
                }

            case .failure(_):
                DispatchQueue.main.async {
                    self.showAlert()
                    self.view = UIView()
                }
            }
        }
    }
}


extension ViewController: BookDetailInfoSectionDelegate {
    func didTapExpendButton(_ isExpanded: Bool) {
        books[currentIndex].isExpanded = isExpanded
        userDefaultService.save(currentIndex, isExpanded)
    }
}

extension ViewController: BookInfoViewDelegate {
    func didTapOrderButton(_ sender: UIButton) {
        if let numStr = sender.titleLabel?.text,
           let num = Int(numStr) {
            currentIndex = num-1
            let isExpended = userDefaultService.get(currentIndex)
            books[currentIndex].isExpanded = isExpended
            rootView.configure(books[currentIndex], num, books.count)
        }
    }
}

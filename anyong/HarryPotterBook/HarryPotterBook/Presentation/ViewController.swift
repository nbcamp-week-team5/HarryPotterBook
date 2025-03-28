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
    
    private var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
    }
    
    override func loadView() {
        view = rootView
        rootView.bookDeatilInfoSection.delegate = self
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
                if let book = books.first {
                    let isExpended = self.userDefaultService.get(0)
                    
                    self.rootView.configure(book, 1, isExpended)
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
    func didTapExpendButton(_ expeded: Bool) {
        userDefaultService.save(0, expeded)
    }
}

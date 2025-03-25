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
    
    private var book: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
        rootView.setOrder(1)
        rootView.setTitle(book[0].title)
    }
    
    override func loadView() {
        view = rootView
    }
}

extension ViewController {
    private func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                self.book = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

//
//  ViewController.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/25/25.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private let bookController = BookController.shared

    private let headerView = HeaderView()
    private let bookInfoView = BookInfoView()
    private let dedicationView = DedicationView()
    private let summaryView = SummaryView()
    private let chaptersView = ChaptersView()
    
    private let dataService = DataService()
    
    
    // ScrollView
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    private lazy var scrollContentsVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 24
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                             
        
        bookController.loadBooks()
        
        bookController
            .setViews(
                mainView: self,
                headerView: headerView,
                bookInfoView: bookInfoView,
                dedicationView: dedicationView,
                summaryView: summaryView,
                chaptersView: chaptersView
            )

        configureLayout()
        

    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        
        [headerView, scrollView].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(scrollContentsVStack)
        
        [bookInfoView, dedicationView, summaryView, chaptersView].forEach {
            scrollContentsVStack.addArrangedSubview($0)
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(130)
        }
        
        scrollContentsVStack.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    // MARK: - Other Functions
    
    
    func showErrorAlert(error: Error) {
        print("에러: \(error)")
        let alert = UIAlertController(
            title: "파일을 불러오지 못했습니다!",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}

#Preview {
    MainViewController()
}

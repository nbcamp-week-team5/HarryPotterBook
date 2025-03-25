//
//  ViewController.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/25/25.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

//    private let dataService = DataService()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Harry Potter and the Philosopher’s Stone"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var seriesOrder: UIButton = {
        let button = UIButton()
        button.setTitle("1", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
//        button.layer.cornerRadius = button.frame.width / 2
        button.layer.cornerRadius = 20

        return button
    }()
    
//    func loadBooks() {
//        dataService.loadBooks { [weak self] result in
//            guard let self = self else { return }
//            
//            switch result {
//            case .success(let books):
//                
//                
//            case .failure(let error):
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        
        [titleLabel, seriesOrder].forEach { UILabel in
            view.addSubview(UILabel)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }
        
        seriesOrder.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
    }


}

#Preview {
    ViewController()
}

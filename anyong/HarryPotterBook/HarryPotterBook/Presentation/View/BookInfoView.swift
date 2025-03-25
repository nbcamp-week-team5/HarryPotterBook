//
//  BookInfoView.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/24/25.
//

import UIKit

import Then
import SnapKit

final class BookInfoView: UIView {
    private let titleLabel = UILabel()
    private let orderButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        self.do {
            $0.backgroundColor = .white
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        orderButton.do {
            $0.titleLabel?.font = .systemFont(ofSize: 16)
            $0.titleLabel?.textAlignment = .center
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemBlue
            $0.layer.cornerRadius = 15
        }
    }
    
    private func setUI() {
        self.addsubViews(titleLabel, orderButton)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        orderButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(30)
        }
    }
}

extension BookInfoView {
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    func setOrder(_ num: Int) {
        self.orderButton.setTitle("\(num)", for: .normal)
    }
}

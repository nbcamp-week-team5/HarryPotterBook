//
//  BookDetailInfoSection.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/26/25.
//

import UIKit

import SnapKit
import Then

final class BookDetailInfoSection: UIView {
    private let dedicationTitleLabel = UILabel()
    private let dedicationLabel = UILabel()
    private let summaryTitleLabel = UILabel()
    private let summaryLabel = UILabel()
    
    private let dedicationStackView = UIStackView()
    private let summaryStackView = UIStackView()
    
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
        dedicationTitleLabel.do {
            $0.text = "Dedication"
            $0.font = .systemFont(ofSize: 18, weight: .bold)
            $0.textColor = .black
        }
        
        dedicationLabel.do {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .darkGray
            $0.numberOfLines = 0
        }
        
        summaryTitleLabel.do {
            $0.text = "Summary"
            $0.font = .systemFont(ofSize: 18, weight: .bold)
            $0.textColor = .black
        }
        
        summaryLabel.do {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .darkGray
            $0.numberOfLines = 0
        }
        
        dedicationStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .leading
        }
        
        summaryStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .leading
        }
    }
    
    private func setUI() {
        dedicationStackView.addArrangedSubViews(dedicationTitleLabel, dedicationLabel)
        summaryStackView.addArrangedSubViews(summaryTitleLabel, summaryLabel)
        addSubViews(dedicationStackView, summaryStackView)
    }
    
    private func setLayout() {
        dedicationStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        summaryStackView.snp.makeConstraints {
            $0.top.equalTo(dedicationStackView.snp.bottom).offset(24)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension BookDetailInfoSection {
    func configure(_ book: Book) {
        dedicationLabel.text = book.dedication
        summaryLabel.text = book.summary
    }
}

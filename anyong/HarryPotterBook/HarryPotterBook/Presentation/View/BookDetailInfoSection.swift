//
//  BookDetailInfoSection.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/26/25.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol BookDetailInfoSectionDelegate: AnyObject {
    func didTapExpendButton(_ isExpanded: Bool)
}

final class BookDetailInfoSection: UIView {
    // MARK: - Properties
    private let dedicationTitleLabel = UILabel()
    private let dedicationLabel = UILabel()
    private let summaryTitleLabel = UILabel()
    private let summaryLabel = UILabel()
    private let expendButton = UIButton(type: .system)
    
    private let dedicationStackView = UIStackView()
    private let summaryStackView = UIStackView()
    
    private var summary: String?
    private var truncatedSummary: String?
    private var isExpanded: Bool = false
    
    weak var delegate: BookDetailInfoSectionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Style
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
        
        expendButton.do {
            $0.setTitle(isExpanded ? "접기" : "더보기", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14)
            $0.titleLabel?.textColor = .systemBlue
            $0.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
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
    
    //MARK: - View Hierarchy
    private func setUI() {
        dedicationStackView.addArrangedSubViews(dedicationTitleLabel, dedicationLabel)
        summaryStackView.addArrangedSubViews(summaryTitleLabel, summaryLabel)
        addSubViews(dedicationStackView, summaryStackView, expendButton)
    }
    
    //MARK: - Layout
    private func setLayout() {
        dedicationStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        summaryStackView.snp.makeConstraints {
            $0.top.equalTo(dedicationStackView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
        }
        
        expendButton.snp.makeConstraints {
            $0.top.equalTo(summaryStackView.snp.bottom)
            $0.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: - Internal Function
extension BookDetailInfoSection {
    func configure(_ book: Book) {
        summary = book.summary
        truncatedSummary = book.truncatedSummary
        dedicationLabel.text = book.dedication
        
        
        guard let truncatedSummary else {
            summaryLabel.text = book.summary
            expendButton.isHidden = true
            
            return
        }
        
        expendButton.isHidden = false
        expendButton.setTitle(book.isExpanded ? "접기" : "더보기", for: .normal)
        summaryLabel.text = book.isExpanded ? book.summary : truncatedSummary
    }
}

//MARK: - Private Function
extension BookDetailInfoSection {
    @objc
    private func expandButtonTapped() {
        isExpanded.toggle()
        guard let summary, let truncatedSummary else { return }
        summaryLabel.text = isExpanded ? summary : truncatedSummary
        expendButton.setTitle(isExpanded ? "접기" : "더보기", for: .normal)
        delegate?.didTapExpendButton(isExpanded)
    }
}

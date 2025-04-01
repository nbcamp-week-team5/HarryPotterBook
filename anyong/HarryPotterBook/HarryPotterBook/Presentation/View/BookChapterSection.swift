//
//  BookChapterSection.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/26/25.
//

import UIKit

import SnapKit
import Then

final class BookChapterSection: UIView {
    private let chapterTitleLabel = UILabel()
    private let chapterStackView = UIStackView()
    
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
        chapterTitleLabel.do {
            $0.text = "Chapters"
            $0.font = .systemFont(ofSize: 18, weight: .bold)
            $0.textColor = .black
        }
        
        chapterStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .leading
        }
    }
    
    private func setUI() {
        addSubViews(chapterTitleLabel, chapterStackView)
    }
    
    private func setLayout() {
        chapterTitleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        chapterStackView.snp.makeConstraints {
            $0.top.equalTo(chapterTitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension BookChapterSection {
    func configure(_ book: Book) {
        if !chapterStackView.subviews.isEmpty {
            let subviews = chapterStackView.arrangedSubviews
            chapterStackView.arrangedSubviews.forEach(chapterStackView.removeArrangedSubview(_:))
            subviews.forEach { $0.removeFromSuperview() }
        }
        
        book.chapters.forEach { chapter in
            let label = UILabel()
            label.text = chapter.title
            label.font = .systemFont(ofSize: 14)
            label.textColor = .darkGray
            label.numberOfLines = 0
            
            chapterStackView.addArrangedSubview(label)
        }
    }
}

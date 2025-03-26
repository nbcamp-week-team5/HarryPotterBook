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
        addSubview(chapterStackView)
        chapterStackView.addArrangedSubview(chapterTitleLabel)
    }
    
    private func setLayout() {
        chapterStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension BookChapterSection {
    func configure(_ book: Book) {
        book.chapters.forEach { chapter in
            let label = UILabel()
            label.text = chapter.title
            label.font = .systemFont(ofSize: 14)
            label.textColor = .darkGray
            label.numberOfLines = 1
            
            chapterStackView.addArrangedSubview(label)
        }
    }
}

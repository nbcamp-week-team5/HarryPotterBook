//
//  ChapterView.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/26/25.
//

import UIKit
import SnapKit

class ChapterView: UIView {
    private let chapterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private let chapterTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Chapters"
        return label
    }()
    
    private let chapterListView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayoutWithSnapKit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(chapterStackView)
        chapterStackView.addArrangedSubview(chapterTitle)
        chapterStackView.addArrangedSubview(chapterListView)
    }
    
    private func setupLayoutWithSnapKit() {
        chapterStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(_ book: Book) {
        self.chapterListView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        book.chapters.enumerated().forEach { (_, chapter) in
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .darkGray
            label.numberOfLines = 0
            label.text = "\(chapter.title)"
            self.chapterListView.addArrangedSubview(label)
        }
    }
    
}

//
//  ChaptersView.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/28/25.
//

import UIKit
import SnapKit

class ChaptersView: UIView {
    
    lazy var chaptersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    lazy var chapters: UILabel = {
        let label = UILabel()
        label.text = "Chapters"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        
        [chapters, chaptersStackView].forEach {
            self.addSubview($0)
        }
        
        chapters.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        chaptersStackView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(chapters.snp.bottom).offset(8)
        }
    }
    
    func removeChatersView() {
        chaptersStackView.arrangedSubviews.forEach {
            chaptersStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    func addChaptersView(_ book: Book) {
        // Chapters View
        for chapter in book.chapters{
            lazy var chaptersLabel: UILabel = {
                let label = UILabel()
                label.text = "1. Chapter"
                label.font = .systemFont(ofSize: 14)
                label.numberOfLines = 0
                label.textColor = .darkGray
                return label
            }()
            chaptersLabel.text = chapter.title
            chaptersStackView.addArrangedSubview(chaptersLabel)
        }
    }
}

//
//  BookInfoView.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/24/25.
//

import UIKit

import Then
import SnapKit

protocol BookInfoViewDelegate: AnyObject {
    func didTapOrderButton(_ sender: UIButton)
}

final class BookInfoView: UIView {
    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let buttonStackView = UIStackView()
    private let bookInfoSection = BookInfoSection()
    let bookDetailInfoSection = BookDetailInfoSection()
    private let bookChapterSection = BookChapterSection()
    
    weak var delegate: BookInfoViewDelegate?
    
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
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.distribution = .fillEqually
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.alwaysBounceVertical = true
        }
    }
    
    private func setUI() {
        addSubViews(titleLabel, buttonStackView, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews(bookInfoSection, bookDetailInfoSection, bookChapterSection)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()                        
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(18)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        bookInfoSection.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        bookDetailInfoSection.snp.makeConstraints {
            $0.top.equalTo(bookInfoSection.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        bookChapterSection.snp.makeConstraints {
            $0.top.equalTo(bookDetailInfoSection.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}

extension BookInfoView {
    func configure(_ book: Book, _ num: Int, _ count: Int) {
        titleLabel.text = book.title

        bookInfoSection.configure(book, num)
        bookDetailInfoSection.configure(book)
        bookChapterSection.configure(book)
        if buttonStackView.subviews.isEmpty {
            for i in 0..<count {
                buttonStackView.addArrangedSubview(makeOrderButton(i+1))
            }
        }
    }
}

extension BookInfoView {
    private func makeOrderButton(_ num: Int) -> UIButton {
        let button = UIButton(type: .system)
        
        button.do {
            $0.setTitle("\(num)", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16)
            $0.titleLabel?.textAlignment = .center
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.setTitleColor(.white, for: [.selected, .disabled])
            $0.tintColor = .clear
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 18
            
            $0.isSelected = num == 1 ? true : false
            $0.setTitle("\(num)", for: .normal)
            $0.backgroundColor = $0.isSelected ? .systemBlue : .systemGray5
            $0.addTarget(self, action: #selector(didTapOrderButton(_:)), for: .touchUpInside)
        }
        
        button.snp.makeConstraints {
            $0.size.equalTo(35)
        }
        
        return button
    }
    
    @objc
    private func didTapOrderButton(_ sender: UIButton) {
        buttonStackView.arrangedSubviews.forEach { view in
            guard let button = view as? UIButton else { return }
            button.isSelected = false
            button.isEnabled = true
            button.backgroundColor = .systemGray5
        }
        
        sender.isSelected = true
        sender.isEnabled = false
        sender.backgroundColor = .systemBlue
        
        delegate?.didTapOrderButton(sender)
    }
}

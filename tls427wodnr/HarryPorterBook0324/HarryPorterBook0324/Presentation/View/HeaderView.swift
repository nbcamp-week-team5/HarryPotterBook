//
//  HeaderView.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/26/25.
//

import UIKit
import SnapKit

protocol HeaderViewDelegate: AnyObject {
    func didTapPageButton(at index: Int)
    func currentPage() -> Int
}

class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let pageButtonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    private let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        //setupLayout()
        setupLayoutWithSnapKit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(headerStackView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(pageButtonStackView)
        
        for index in 0..<7 {
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.setTitle("\(index+1)", for: .normal)
            button.layer.cornerRadius = 16
            button.tag = index
            button.addTarget(self, action: #selector(clickPageButton), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 32),
                button.heightAnchor.constraint(equalToConstant: 32),
            ])
            
            pageButtonStackView.addArrangedSubview(button)
        }
    }
    
//    private func setupLayout() {
//        headerStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            headerStackView.topAnchor.constraint(equalTo: topAnchor),
//            headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
    
    private func setupLayoutWithSnapKit() {
        headerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(_ text: String) {
        titleLabel.text = text
    }
    
    func setPageButtonColor() {
        guard let currentPage = delegate?.currentPage() else { return }
        for case let button as UIButton in pageButtonStackView.arrangedSubviews {
            if button.tag == currentPage {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .systemGray4
                button.setTitleColor(.systemBlue, for: .normal)
            }
        }
    }
    
    @objc func clickPageButton(_ sender: UIButton) {
        delegate?.didTapPageButton(at: sender.tag)
    }
    
}

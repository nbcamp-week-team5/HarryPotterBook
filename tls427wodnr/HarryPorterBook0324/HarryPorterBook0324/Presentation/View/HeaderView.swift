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
        setupLayoutWithSnapKit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(headerStackView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(pageButtonStackView)
        configureButtons(7)
    }
    
    private func setupLayoutWithSnapKit() {
        headerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureButtons(_ count: Int) {
        for index in 0..<count {
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.setTitle("\(index+1)", for: .normal)
            button.layer.cornerRadius = 16
            button.tag = index
            button.addTarget(self, action: #selector(clickPageButton), for: .touchUpInside)
            button.snp.makeConstraints {
                $0.width.height.equalTo(32)
            }
            pageButtonStackView.addArrangedSubview(button)
        }
    }
    
    func configureTitleLabel(_ text: String) {
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

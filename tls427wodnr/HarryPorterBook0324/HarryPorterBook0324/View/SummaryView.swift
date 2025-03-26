//
//  SummaryView.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/26/25.
//

import UIKit

protocol SummaryViewDelegate: AnyObject {
    func getCurrentSummaryButtonTitle() -> String
    func didTapSummaryButton()
}

class SummaryView: UIView {
    
    weak var delegate: SummaryViewDelegate?
    
    private let summaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private let summaryTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Summary"
        return label
    }()
    
    private let bookSummary: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let summaryButtonWrapper: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.distribution = .fill
        return stackView
    }()
    
    private let spacer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(summaryStackView)
        summaryStackView.addArrangedSubview(summaryTitle)
        summaryStackView.addArrangedSubview(bookSummary)
        
        summaryButtonWrapper.addArrangedSubview(spacer)
        summaryButtonWrapper.addArrangedSubview(summaryButton)
        summaryStackView.addArrangedSubview(summaryButtonWrapper)
    }
    
    private func setupLayout() {
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryButtonWrapper.widthAnchor.constraint(equalTo: summaryStackView.widthAnchor),
            
            summaryStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            summaryStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            summaryStackView.topAnchor.constraint(equalTo: topAnchor),
            summaryStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(summaryCount: Int,formattedSummary: String) {
        self.summaryButton.isHidden = summaryCount < 450
        self.bookSummary.text = formattedSummary
    }
    
    private lazy var summaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(clickSummaryButton), for: .touchUpInside)
        return button
    }()
    
    func setupSummaryButton() {
        self.summaryButton.setTitle(delegate?.getCurrentSummaryButtonTitle(), for: .normal)
    }
    
    @objc func clickSummaryButton() {
        delegate?.didTapSummaryButton()
    }
}

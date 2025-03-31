//
//  DedicationView.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/26/25.
//

import UIKit
import SnapKit

class DedicationView: UIView {
    
    private let dedicationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private let dedicationTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Dedication"
        return label
    }()
    
    private let bookDedication: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
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
        addSubview(dedicationStackView)
        dedicationStackView.addArrangedSubview(dedicationTitle)
        dedicationStackView.addArrangedSubview(bookDedication)
    }
    
//    private func setupLayout() {
//        dedicationStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            dedicationStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            dedicationStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            dedicationStackView.topAnchor.constraint(equalTo: topAnchor),
//            dedicationStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
    
    private func setupLayoutWithSnapKit() {
        dedicationStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(_ text: String) {
        bookDedication.text = text
    }
}

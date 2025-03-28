//
//  DedicationVIew.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/28/25.
//

import UIKit
import SnapKit

class DedicationView: UIView {
    
    // MARK: - Dedication, Summary
    // Dedication
    private lazy var dedicationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    private lazy var dedication: UILabel = {
        let label = UILabel()
        label.text = "Dedication"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    lazy var dedicationLabel: UILabel = {
        let label = UILabel()
        label.text = "Dedication..."
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .darkGray
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
        
        self.addSubview(dedicationStackView)
        
        [dedication, dedicationLabel].forEach {
            dedicationStackView.addArrangedSubview($0)
        }
        
        dedicationStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//
//  DedicationVIew.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/28/25.
//

import UIKit
import SnapKit

class DedicationView: UIView {
    
    private lazy var dedicationStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [dedication, dedicationLabel]
        )
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
    private lazy var dedicationLabel: UILabel = {
        let label = UILabel()
        label.text = "Dedication..."
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        self.addSubview(dedicationStackView)
        
        dedicationStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(_ book: Book) {
        dedicationLabel.text = book.dedication
    }
}

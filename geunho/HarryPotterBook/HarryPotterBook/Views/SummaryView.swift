//
//  SummaryView.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/28/25.
//

import UIKit
import SnapKit

let defaults = UserDefaults.standard

class SummaryView: UIView {
        
    private var seriesNumber: Int
    private var book: Book?
    
    private var isFolded: Bool {
        didSet {
            defaults.set(isFolded, forKey: "summaryButtonState_\(seriesNumber)")
        }
    }
    
    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [summary, summaryLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    private lazy var summary: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    private lazy var summaryLabel: UILabel = {
        var label = UILabel()
        label.text = "Summary..."
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    // 더 보기/접기 버튼
    private lazy var summaryButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.addTarget(
            self,
            action: #selector(summaryButtonClicked),
            for: .touchUpInside
        )
        button.isHidden = true
        return button
    }()
    private lazy var summaryButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [summaryButton])
        stackView.axis = .vertical
        stackView.alignment = .trailing
        return stackView
    }()
    
    init(frame: CGRect, seriesNumber: Int) {
        self.seriesNumber = seriesNumber
        self.isFolded = defaults.bool(forKey: "summaryButtonState_\(seriesNumber)")
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        [summaryStackView, summaryButtonStackView].forEach {
            self.addSubview($0)
        }
        
        summaryStackView.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.bottom.equalTo(summaryButtonStackView.snp.top)
        }
        
        summaryButtonStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
      
    }
    
    func adjustSummaryText(_ book: Book) {
        
        guard let summaryText = summaryLabel.text else {
            return
        }
        
        summaryButton.isHidden = summaryText.count < 450 ? true : false
        
        if self.isFolded && summaryText.count >= 450 {
            summaryButton.setTitle("더보기", for: .normal)
            let truncatedText = summaryText.prefix(450)
            summaryLabel.text = String(truncatedText + "...")
        } else {
            summaryButton.setTitle("접기", for: .normal)
            summaryLabel.text = book.summary
        }
        
    }
    
    private func updateSeriesNumber(_ seriesNumber: Int) {
        self.seriesNumber = seriesNumber
        self.isFolded = defaults.bool(forKey: "summaryButtonState_\(seriesNumber)")
    }
    
    @objc func summaryButtonClicked() {
        
        self.isFolded.toggle()
        
        if let book = book {
            adjustSummaryText(book)
        }
    }
    
    func configure(_ book: Book, at seriesNumber: Int) {
        self.book = book
        updateSeriesNumber(seriesNumber)
        summaryLabel.text = book.summary
        adjustSummaryText(book)
    }
}

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
    
    private var isFolded: Bool {
        didSet {
            defaults.set(isFolded, forKey: "summaryButtonState_\(seriesNumber)")
        }
    }
    
    private var tempString = ""

    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView()
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
    lazy var summaryLabel: UILabel = {
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
        button.setTitle("더 보기", for: .normal)
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
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        return stackView
    }()
    
    init(frame: CGRect, seriesNumber: Int) {
        self.seriesNumber = seriesNumber
        self.isFolded = defaults.bool(forKey: "summaryButtonState_\(seriesNumber)")
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        
        [summaryStackView, summaryButtonStackView].forEach {
            self.addSubview($0)
        }
        
        [summary, summaryLabel].forEach {
            summaryStackView.addArrangedSubview($0)
        }
        
       summaryButtonStackView.addArrangedSubview(summaryButton)
        
        summaryStackView.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.bottom.equalTo(summaryButtonStackView.snp.top)
        }
        
        summaryButtonStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
      
    }
    
    func detectSummaryText() {
        guard let summaryText = summaryLabel.text else {
            summaryButton.isHidden = true
            return
        }
        
        if summaryText.count >= 450 {
            summaryButton.isHidden = false
            tempString = summaryText
            
            adjustSummaryText()
            
            if self.isFolded {
                summaryButton.setTitle("더보기", for: .normal)
            } else {
                summaryButton.setTitle("접기", for: .normal)
            }
        } else {
            summaryButton.isHidden = true
        }
    }
    
    func adjustSummaryText() {
        
        guard let summaryText = summaryLabel.text else {
            return
        }
        
        if self.isFolded {
            tempString = summaryText
            
            if summaryText.count > 450 {
                let startIndex = summaryText.index(summaryText.startIndex, offsetBy: 450)
                let endIndex = summaryText.endIndex
                
                var truncatedText = summaryText
                truncatedText.replaceSubrange(startIndex..<endIndex, with: "...")
                summaryLabel.text = truncatedText
            }
        } else {
            summaryLabel.text = tempString
        }
    }
    
    func updateSeriesNumber(_ seriesNumber: Int) {
        self.seriesNumber = seriesNumber
        self.isFolded = defaults.bool(forKey: "summaryButtonState_\(seriesNumber)")
        detectSummaryText()
    }
    
    @objc func summaryButtonClicked() {
        
        if !self.isFolded {
            summaryButton.setTitle("더보기", for: .normal)
            self.isFolded = true
        } else {
            summaryButton.setTitle("접기", for: .normal)
            self.isFolded = false
        }
        
        adjustSummaryText()
        
    }
}

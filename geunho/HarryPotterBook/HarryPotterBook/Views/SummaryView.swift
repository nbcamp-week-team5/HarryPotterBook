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
    
    var isFolded = defaults.bool(forKey: "summaryButtonState")
    private var tempString = ""


    // Summary
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
    lazy var summaryButton: UIButton = {
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
    lazy var summaryButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        
        self.addSubview(summaryStackView)
        
        [summary, summaryLabel].forEach {
            summaryStackView.addArrangedSubview($0)
        }
        
        summaryButtonStackView.addArrangedSubview(summaryButton)
        
        summaryStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        summaryButtonStackView.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
      
    }
    
    func adjustSummaryText() {
        
        if self.isFolded {
            tempString = summaryLabel.text!
            let startIndex = summaryLabel.text!.index(summaryLabel.text!.startIndex, offsetBy: 450)
            let endIndex = summaryLabel.text!.endIndex
            
            summaryLabel.text?
                .replaceSubrange(startIndex..<endIndex, with: "...")
        }
        else {
            summaryLabel.text = tempString
        }
    }
    
    func detectSummaryText() {
        if summaryLabel.text!.count >= 450 {
            summaryButton.isHidden = false
            tempString = summaryLabel.text!
            adjustSummaryText()
            
            if self.isFolded {
                summaryButton.setTitle("더보기", for: .normal)
            } else {
                summaryButton.setTitle("접기", for: .normal)
            }
            
            
        }
    }
    
    @objc func summaryButtonClicked() {
        
        if !self.isFolded {
            summaryButton.setTitle("더보기", for: .normal)
            self.isFolded = !self.isFolded
        } else {
            summaryButton.setTitle("접기", for: .normal)
            self.isFolded = !self.isFolded
        }
        
        adjustSummaryText()
        
        defaults.set(isFolded, forKey: "summaryButtonState")
    }
}

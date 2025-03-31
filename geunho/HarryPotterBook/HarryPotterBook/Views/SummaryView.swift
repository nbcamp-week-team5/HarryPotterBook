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
    
    var seriesCount = BookController.shared.seriesCount
        
    private let seriesNumber: Int
    
    private var isFolded: Bool {
        // didSet - 속성의 값이 변경된 직후 실행
        didSet {
            defaults.set(isFolded, forKey: "summaryButtonState_\(seriesNumber)")
        }
    }
    
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
        return stackView
    }()
    
    init(frame: CGRect, num: Int) {
        self.seriesNumber = num
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
            // width.equalTo로 하니 레이아웃 오류 발생
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
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
        } else {
            summaryButton.isHidden = true
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

//
//  HeaderView.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/28/25.
//

import UIKit
import SnapKit

protocol HeaderViewDelegate: AnyObject {
    func headerView(_ headerView: HeaderView, didSelectSeries seriesNumber: Int)
}

class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
        
    var selectedButton: UIButton?
    
    lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Harry Potter"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var seriesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var seriesButtonHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
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
        
        [mainTitleLabel, seriesScrollView].forEach {
            self.addSubview($0)
        }
        
        seriesScrollView.addSubview(seriesButtonHStack)
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(seriesScrollView.snp.top).offset(-16)
        }

        seriesScrollView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(seriesButtonHStack.snp.width)
        }
        
        seriesButtonHStack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.height.equalToSuperview()
            make.centerX.greaterThanOrEqualToSuperview()
        }
    }
    
    // series 개수에 따라 seriesButton 추가
    func addSeriesButtons(_ seriesCount: Int) {
        for seriesNumber in 1 ... seriesCount {
            let seriesButton: UIButton = {
                let button = UIButton()
                button.setTitle("\(seriesNumber)", for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
                if seriesNumber == 1 {
                    button.setTitleColor(.white, for: .normal)
                    button.backgroundColor = .systemBlue
                } else {
                    button.setTitleColor(.systemBlue, for: .normal)
                    button.backgroundColor = .systemGray5
                }
                button
                    .addTarget(
                        self,
                        action: #selector(changeSeries(_:)),
                        for: .touchUpInside
                    )
                button.layer.cornerRadius = 22
                button.layer.masksToBounds = true
                return button
            }()
            seriesButtonHStack.addArrangedSubview(seriesButton)
            seriesButton.snp.makeConstraints { make in
                make.width.height.equalTo(44)
            }
            if seriesNumber == 1 {
                selectedButton = seriesButton
            }
        }
    }
    
    // 시리즈 변경 시 해당 내용 load
    @objc func changeSeries(_ sender: UIButton) {
        guard let titleText = sender.title(for: .normal),
              let seriesNumber = Int(titleText) else {
            print("Error: Invalid series number")
            return
        }
        
        var prevButton: UIButton?
        
        if sender != selectedButton {
            prevButton = selectedButton
            selectedButton = sender
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = .systemBlue
            prevButton?.setTitleColor(.systemBlue, for: .normal)
            prevButton?.backgroundColor = .systemGray5
        }
        
        delegate?.headerView(self, didSelectSeries: seriesNumber)
    }
}

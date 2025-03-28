//
//  HeaderView.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/28/25.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Harry Potter"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
     lazy var seriesButton: UIButton = {
        var button = UIButton()
        button.setTitle("1", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    // codebase
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
    }
    
    // storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        
                
        [mainTitleLabel, seriesButton].forEach {
            self.addSubview($0)
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        seriesButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        
    }
}

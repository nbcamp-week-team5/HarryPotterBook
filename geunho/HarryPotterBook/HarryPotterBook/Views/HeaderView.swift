//
//  HeaderView.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/28/25.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    var bookController = BookController.shared

    
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
    
    func addSeriesButtons(_ seriesCount: Int) {
        for num in 1 ... seriesCount {
            let seriesButton: UIButton = {
                let button = UIButton()
                button.setTitle("\(num)", for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
                button.setTitleColor(.systemBlue, for: .normal)
                button.backgroundColor = .systemGray5
                button
                    .addTarget(
                        self,
                        // changeSeries(_:)는 sender라는 UIButton 타입의 파라미터를 받는 메서드를 의미합니다.
                        // addTarget은 버튼 이벤트 핸들러로 호출될 메서드가 반드시 sender를 파라미터로 받는 형태여야 한다고 기대합니다. 즉, func changeSeries(_ sender: UIButton) 같은 형태가 기본입니다.
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
            
        }
    }
    
    @objc func changeSeries(_ sender: UIButton) {
        let seriesNumber = Int(sender.title(for: .normal)!)!
        print("Selected series: \(seriesNumber)")
        
        // 여기서 seriesNumber를 사용해 데이터 설정 로직 추가
        sender.setTitleColor(.white, for: .normal)
        sender.backgroundColor = .systemBlue
        
        bookController.loadBooks(seriesNumber)
    }
}

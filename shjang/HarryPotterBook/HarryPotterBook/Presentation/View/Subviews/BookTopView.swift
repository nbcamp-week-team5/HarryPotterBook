import UIKit

protocol BookTopViewDelegate: AnyObject {
    func bookTopViewDidTapBookButton(_ bookTopView: BookTopView, at index: Int)
}

final class BookTopView: UIView {
    weak var delegate: BookTopViewDelegate?
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(buttonsStackView)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func updateButtonStyle(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.borderWidth = 0
        } else {
            button.backgroundColor = .white
            button.setTitleColor(.systemBlue, for: .normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    
    private func createButton(index: Int, isSelected: Bool) -> UIButton {
        let button = UIButton(type: .custom)
        button.tag = index
        button.setTitle("\(index + 1)", for: .normal)
        
        updateButtonStyle(button, isSelected: isSelected)
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.snp.makeConstraints {
            $0.width.height.equalTo(32)
        }
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }
    
    func configure(with books: [Book], selectedIndex: Int = 0) {
        buttonsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        self.selectedIndex = selectedIndex
        if selectedIndex >= 0 && selectedIndex < books.count {
            titleLabel.text = books[selectedIndex].title
        }
        
        for index in 0..<books.count {
            let button = createButton(index: index,
                                      isSelected: index == selectedIndex)
            buttonsStackView.addArrangedSubview(button)
            buttons.append(button)
        }
    }
    
    func updateSelectedButton(at index: Int) {
        guard index >= 0 && index < buttons.count else { return }
        if selectedIndex < buttons.count {
            updateButtonStyle(buttons[selectedIndex], isSelected: false)
        }
        selectedIndex = index
        updateButtonStyle(buttons[selectedIndex], isSelected: true)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        guard index != selectedIndex else { return }
        updateSelectedButton(at: index)
        delegate?.bookTopViewDidTapBookButton(self, at: index)
    }
}

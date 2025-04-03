import UIKit
import SnapKit

protocol BookDetailViewDelegate: AnyObject {
    func bookDetailViewDidTapButton(_ view: BookDetailView)
}

final class BookDetailView: UIView {
    // MARK: Properties
    weak var delegate: BookDetailViewDelegate?
    private lazy var expandButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Expand", for: .normal)
        button.addTarget(self, action: #selector(handleExpandButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var dedicationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Dedication"
        label.textColor = .black
        return label
    }()
    
    private lazy var dedicationContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var dedicationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dedicationTitleLabel, dedicationContentLabel]
        )
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Summary"
        label.textColor = .black
        return label
    }()
    
    private lazy var summaryContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                        [summaryTitleLabel, summaryContentLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(dedicationStackView)
        addSubview(summaryStackView)
        addSubview(expandButton)
    }
    
    private func setupConstraints() {
        dedicationStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        summaryStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(dedicationStackView.snp.bottom).offset(24)
        }
        
        expandButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(summaryStackView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func handleExpandButtonTapped() {
        delegate?.bookDetailViewDidTapButton(self)
    }
    
    func configure(with book: Book, isExpanded: Bool) {
        dedicationContentLabel.text = book.dedication
        let summary = book.summary
        if summary.count > 450 {
            if isExpanded {
                summaryContentLabel.text = summary
                expandButton.setTitle("Fold", for: .normal)
            } else {
                summaryContentLabel.text = String(summary.prefix(450)) + "…"
                expandButton.setTitle("Expand", for: .normal)
            }
            expandButton.isHidden = false
        } else {
            summaryContentLabel.text = summary
            expandButton.isHidden = true
        }
    }
}

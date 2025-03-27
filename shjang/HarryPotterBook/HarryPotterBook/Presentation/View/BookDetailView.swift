import UIKit
import SnapKit

final class BookDetailView: UIView {
    // MARK: Properties
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
        let stackView = UIStackView(arrangedSubviews: [summaryTitleLabel, summaryContentLabel]
        )
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
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
    }
    
    private func setupConstraints() {
        dedicationStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        summaryStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(dedicationStackView.snp.bottom).offset(24)
        }
    }
    
    func configure(with book: Book) {
        dedicationContentLabel.text = book.dedication
        summaryContentLabel.text = book.summary
    }
}

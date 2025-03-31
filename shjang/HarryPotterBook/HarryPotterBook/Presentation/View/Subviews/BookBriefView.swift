import UIKit
import SnapKit

final class BookBriefView: UIView {
    // MARK: Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var authorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = "Author"
        return label
    }()
    
    private lazy var authorAttributeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            authorTitleLabel, authorAttributeLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var releaseTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.text = "Released"
        return label
    }()
    
    private lazy var releaseAttributeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var releaseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            releaseTitleLabel, releaseAttributeLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var pagesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.text = "Pages"
        return label
    }()
    
    private lazy var pagesAttributeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var pagesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            pagesTitleLabel, pagesAttributeLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var bookInfoStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        titleLabel, authorStackView, releaseStackView, pagesStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        return stackView
    }()
    
    private lazy var bookImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    private lazy var bookContainerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            bookImageView, bookInfoStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .top
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(bookContainerView)
    }
    
    private func setupConstraint() {
        bookContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bookImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }
    }
    
    func configure(with book: Book, data: Data){
        titleLabel.text = book.title
        authorAttributeLabel.text = book.author
        releaseAttributeLabel.text = book.releaseDate ?? "Unknown"
        pagesAttributeLabel.text = "\(book.pages)"
        if let image = UIImage(data: data) {
            bookImageView.image = UIImage(data: data)
        } else {
            print("Failed to set image")
        }
    }
}

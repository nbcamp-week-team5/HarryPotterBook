import UIKit

final class BookChapterView: UIView {
    private lazy var chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chapters"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var chapterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [chapterTitleLabel])
        stackView.axis = .vertical
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
        addSubview(chapterStackView)
    }
    
    private func setupConstraints() {
        chapterStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with chapters: [Chapter]) {
        clearChapters()
        chapters.forEach { addChapter($0.title) }
    }
    
    func addChapter(_ chapterTitle: String) {
        let label = UILabel()
        label.text = chapterTitle
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        chapterStackView.addArrangedSubview(label)
    }
    
    func clearChapters() {
        for view in chapterStackView.arrangedSubviews {
            if view !== chapterTitleLabel {
                chapterStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
    }
}

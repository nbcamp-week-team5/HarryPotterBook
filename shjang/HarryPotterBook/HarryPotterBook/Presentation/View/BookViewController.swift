import UIKit
import SnapKit

final class BookViewController: UIViewController {
    private var viewModel: BookViewModel
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let seriesOrderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.layer.cornerRadius = 15
        return label
    }()
    
    init(viewModel: BookViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
    }
    
    private func setupLocalizations() {
    }
    
    func didUpdateSelectedBook(_ book: Book?) {
        if let book = book {
            titleLabel.text = book.title
            seriesOrderLabel.text = "\(String(describing: book.seriesOrder))"
        }
    }
    
    private func bind(to viewModel: BookViewModel) {
        viewModel.onBookSelected = { [weak self] book in
            if let book = book {
                self?.titleLabel.text = book.title
                self?.seriesOrderLabel.text = "\(String(describing: book.seriesOrder))"
            }
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
    }
}

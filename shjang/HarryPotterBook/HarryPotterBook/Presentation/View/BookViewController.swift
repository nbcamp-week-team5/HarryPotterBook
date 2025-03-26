import UIKit
import SnapKit

final class BookViewController: UIViewController {
    private var viewModel: BookViewModel
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var seriesOrderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    init(viewModel: BookViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUICurrentBook()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        seriesOrderLabel.layer.cornerRadius = seriesOrderLabel.frame.height / 2
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(seriesOrderLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        seriesOrderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.width.height.equalTo(30)
        }
    }
        
    func updateUICurrentBook() {
        if let currentBook = viewModel.selectedBook {
            titleLabel.text = currentBook.title
            seriesOrderLabel.text = "\(String(describing: currentBook.seriesOrder!))"
        }
    }
    
    func updateUILabel(with book: Book) {
        titleLabel.text = book.title
        seriesOrderLabel.text = "\(String(describing: book.seriesOrder!))"
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
    }
}

extension BookViewController: BookViewModelDelegate {
    func didUpdateSelectedBook(_ viewModel: BookViewModel, _ book: Book?) {
        if let book = book {
            DispatchQueue.main.async {
                self.updateUILabel(with: book)
            }
        }
    }
    
    func didFailToLoadBook(_ viewModel: BookViewModel, _ error: any Error) {
        showError("Failed To Load ViewModel" )
    }
}

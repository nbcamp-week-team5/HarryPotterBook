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
    
    private lazy var bookBriefView: BookBriefView = {
        let view = BookBriefView()
        return view
    }()
    
    private lazy var bookDetailView: BookDetailView = {
        let view = BookDetailView()
        return view
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
        view.addSubview(bookBriefView)
        view.addSubview(bookDetailView)
        setupConstraints()
    }
    
    private func setupConstraints() {
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
        
        bookBriefView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(seriesOrderLabel.snp.bottom).offset(10)
        }
        
        bookDetailView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(bookBriefView.snp.bottom).offset(24)
        }
    }
        
    func updateUICurrentBook() {
        if let currentBook = viewModel.selectedBook {
            titleLabel.text = currentBook.title
            seriesOrderLabel.text = "\(String(describing: currentBook.seriesOrder!))"
            bookBriefView.configure(with: currentBook)
            bookDetailView.configure(with: currentBook)
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
    
    func didFailedToLoadImage(_ viewModel: BookViewModel, _ error: any Error) {
        showError("Failed To Load Image")
    }
}

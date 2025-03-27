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
    
    private lazy var bookChapterView: BookChapterView = {
        let view = BookChapterView()
        return view
    }()
    
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            bookBriefView, bookDetailView, bookChapterView
        ])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
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
        contentStackView.layoutIfNeeded()
        contentScrollView.contentSize = CGSize(width: contentScrollView.bounds.width, height: contentStackView.bounds.height)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(seriesOrderLabel)
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        seriesOrderLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(30)
        }
        
        contentScrollView.snp.makeConstraints {
            $0.top.equalTo(seriesOrderLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(contentScrollView.snp.width).offset(-40)
        }
    }
        
    func updateUICurrentBook() {
        if let currentBook = viewModel.selectedBook {
            titleLabel.text = currentBook.title
            seriesOrderLabel.text = "\(String(describing: currentBook.seriesOrder!))"
            bookBriefView.configure(with: currentBook)
            bookDetailView.configure(with: currentBook)
            
            for i in 0..<currentBook.chapters.count {
                bookChapterView.addChapter(currentBook.chapters[i].title)
            }
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

extension BookViewController: UIScrollViewDelegate {
    
}

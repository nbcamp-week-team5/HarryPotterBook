import UIKit
import SnapKit

final class BookViewController: UIViewController {
    private var viewModel: BookViewModel
    private lazy var bookTopView: BookTopView = {
        let view = BookTopView()
        return view
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
        viewModel.delegate = self
        bookTopView.delegate = self
        bookDetailView.delegate = self
    }
    
    @available(*, unavailable)
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentStackView.layoutIfNeeded()
        contentScrollView.contentSize = CGSize(
            width: contentScrollView.bounds.width,
            height: contentStackView.bounds.height)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(bookTopView)
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStackView)
    }
    
    private func setupConstraints() {
        bookTopView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.height.equalTo(100)
        }
        
        contentScrollView.snp.makeConstraints {
            $0.top.equalTo(bookTopView.snp.bottom).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.bottom.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(contentScrollView.snp.width).offset(-40)
        }
    }
        
    func updateUI() {
        bookTopView.configure(with: viewModel.books)
        if let currentBook = viewModel.selectedBook {
            if let data = viewModel.getImageData(for: viewModel.selectedIndex + 1) {
                bookBriefView.configure(with: currentBook, data: data)
            }
            bookDetailView.configure(with: currentBook, isExpanded: viewModel.isExpanded)
            bookChapterView.configure(with: currentBook.chapters)
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        let alertController = UIAlertController(
            title: "Error",
            message: error,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

extension BookViewController: BookViewModelDelegate {
    func didCompleteAllImageLoading(_ viewModel: BookViewModel) {
        updateUI()
    }
    
    func didUpdateSelectedBook(_ viewModel: BookViewModel, _ book: Book?) {
        if let book = book {
            if let data = viewModel.getImageData(for: viewModel.selectedIndex + 1) {
                bookBriefView.configure(with: book, data: data)
            }
            
            bookDetailView.configure(with: book, isExpanded: viewModel.isExpanded)
            bookChapterView.clearChapters()
            bookChapterView.configure(with: book.chapters)
        }
    }
    
    func didFailToLoadBook(_ viewModel: BookViewModel, _ error: any Error) {
        showError("Failed To Parse Book: \(error.localizedDescription)")
    }
    
    func didFailToLoadImage(_ viewModel: BookViewModel, _ error: any Error) {
        showError("Failed To Load Imge: \(error.localizedDescription)")
    }
    
    func didUpdateExpandedState(_ viewModel: BookViewModel, _ index: Int) {
        if let currentBook = viewModel.selectedBook {
            bookDetailView.configure(with: currentBook, isExpanded: viewModel.isExpanded)
        }
    }
}

extension BookViewController: BookTopViewDelegate {
    func bookTopViewDidTapBookButton(_ bookTopView: BookTopView, at index: Int) {
        viewModel.selectBook(at: index)
    }
}

extension BookViewController: BookDetailViewDelegate {
    func bookDetailViewDidTapButton(_ view: BookDetailView) {
        viewModel.toggleExpanded(for: viewModel.selectedIndex)
    }
}

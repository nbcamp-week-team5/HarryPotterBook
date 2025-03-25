import Foundation

final class BookDIContainer {
    func makeDataService() -> DataService {
        return DataService()
    }
    
    func makeBookViewModel() -> BookViewModel {
        return BookViewModel(dataService: makeDataService())
    }
    
    func makeBookViewController() -> BookViewController {
        return BookViewController(viewModel: makeBookViewModel())
    }
}

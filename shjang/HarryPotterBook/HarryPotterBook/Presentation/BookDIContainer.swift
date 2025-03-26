import UIKit

final class BookDIContainer: BookFlowCoordinatorDependencies {
    struct Dependencies {
        let appConfiguration: AppConfiguration
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeDataService() -> DataService {
        return DataService()
    }
    
    func makeBookViewModel() -> BookViewModel {
        return BookViewModel(dataService: makeDataService())
    }
    
    func makeBookViewController() -> BookViewController {
        return BookViewController(viewModel: makeBookViewModel())
    }
    
    func makeBookFlowCoordinator(navigationController: UINavigationController) -> BookFlowCoordinator
    {
        BookFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

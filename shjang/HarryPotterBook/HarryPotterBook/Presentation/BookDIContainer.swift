import UIKit

final class BookDIContainer: BookFlowCoordinatorDependencies {
    struct Dependencies {
        let appConfiguration: AppConfiguration
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeDataLoader() -> DataLoader {
        return DataLoader()
    }
    
    func makeUserDefaultsService() -> UserDefaultsStorageService {
        return UserDefaultsStorageService()
    }
    
    func makeImageLoader() -> ImageLoaderService {
        return ImageLoader.shared
    }
    
    func makeBookViewModel() -> BookViewModel {
        return BookViewModel(dataService: makeDataLoader(), userDefaultsService: makeUserDefaultsService())
    }
    
    func makeBookViewController() -> BookViewController {
        return BookViewController(viewModel: makeBookViewModel())
    }
    
    func makeBookFlowCoordinator(navigationController: UINavigationController) -> BookFlowCoordinator
    {
        BookFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

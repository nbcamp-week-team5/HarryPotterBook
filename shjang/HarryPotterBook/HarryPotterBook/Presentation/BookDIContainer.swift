import UIKit

final class BookDIContainer: BookFlowCoordinatorDependencies {
    struct Dependencies {
        let appConfiguration: AppConfiguration
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeDataLoader() -> DataService {
        return DataLoader()
    }
    
    func makeUserDefaultsService() -> UserDefaultsStorageService {
        return UserDefaultsStorageService()
    }
    
    func makeImageCahce() -> ImageCache {
        return ImageCache()
    }
    
    func makeImageLoader() -> ImageLoaderService {
        return ImageLoader(cache: makeImageCahce())
    }
    
    func makeBookViewModel() -> BookViewModel {
        return BookViewModel(dataService: makeDataLoader(),
                             userDefaultsService: makeUserDefaultsService(),
                             imageLoader: makeImageLoader())
    }
    
    func makeBookViewController() -> BookViewController {
        return BookViewController(viewModel: makeBookViewModel())
    }
    
    func makeBookFlowCoordinator(navigationController: UINavigationController) -> BookFlowCoordinator
    {
        BookFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

import UIKit

protocol BookFlowCoordinatorDependencies {
    func makeBookViewController() -> BookViewController
}

final class BookFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: BookFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController,
         dependencies: BookFlowCoordinatorDependencies)
    {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewController = dependencies.makeBookViewController()
        navigationController?.pushViewController(viewController, animated: false)
    }
}

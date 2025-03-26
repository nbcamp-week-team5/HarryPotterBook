import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let bookDIContainer = appDIContainer.makeBookDIConatiner()
        let flow = bookDIContainer.makeBookFlowCoordinator(
            navigationController: navigationController
        )
        flow.start()
    }
}

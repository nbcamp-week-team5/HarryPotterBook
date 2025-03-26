import Foundation
final class AppDIContainer {
    lazy var appConfiguration = AppConfiguration()
    
    func makeBookDIConatiner() -> BookDIContainer {
        let dependencies = BookDIContainer.Dependencies(appConfiguration: appConfiguration)
        return BookDIContainer(dependencies: dependencies)
    }
}

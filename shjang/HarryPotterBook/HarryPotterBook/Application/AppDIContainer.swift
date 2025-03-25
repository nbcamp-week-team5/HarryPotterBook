import Foundation
final class AppDIContainer {
    lazy var appConfiguration = AppConfiguration()
    
    func makeBookDIConatiner() -> BookDIContainer {
        return BookDIContainer()
    }
    
    func makeBookViewController() -> BookViewController {
        let bookDIContainer = makeBookDIConatiner()
        return bookDIContainer.makeBookViewController()
    }
}

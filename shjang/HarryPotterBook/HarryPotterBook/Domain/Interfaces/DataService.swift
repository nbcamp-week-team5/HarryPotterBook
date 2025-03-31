import Foundation

protocol DataServiceProtocol {
    func parseBook(completion: @escaping (Result<[Book], Error>) -> Void)
}

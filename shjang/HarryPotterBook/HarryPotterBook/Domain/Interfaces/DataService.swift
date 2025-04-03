import Foundation

protocol DataService {
    func parseBook(completion: @escaping (Result<[Book], Error>) -> Void)
}

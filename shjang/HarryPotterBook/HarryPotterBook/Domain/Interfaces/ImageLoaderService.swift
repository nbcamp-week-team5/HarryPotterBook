import UIKit

protocol ImageLoaderService {
    func loadImage(with id: String) async throws -> Data
}

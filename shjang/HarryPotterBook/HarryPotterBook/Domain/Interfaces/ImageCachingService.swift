import UIKit

enum CacheOption {
    case none
    case memory
    case disk
}

protocol ImageCachingService {
    func imageData(for key: String, option: CacheOption) -> Data?
    func setImageData(_ data: Data, for key: String, option: CacheOption)
}

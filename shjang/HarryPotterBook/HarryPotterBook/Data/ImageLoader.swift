import UIKit

final class ImageLoader: ImageLoaderService {
    enum ImageLoaderError: Error {
        case networkError(Error)
        case invalidResponse
        case InvalidImageData
        
        var localizedDescription: String {
            switch self {
            case .networkError(let error):
                return "Network error: \(error.localizedDescription)"
            case .invalidResponse:
                return "Invalid HTTP response"
            case .InvalidImageData:
                return "Invalid image data"
            }
        }
    }
    
    private let cache: ImageCachingService
    
    init(cache: ImageCachingService) {
        self.cache = cache
    }
    
    func loadImage(with id: String) async throws -> Data {
        if let cachedData = cache.imageData(for: id, option: .disk) {
            return cachedData
        }
        
        let baseURL = AppConfiguration.imageURL
        let imageURL = baseURL.appendingPathComponent("\(id).jpg")
        let (data, response) = try await URLSession.shared.data(from: imageURL)
            
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            throw ImageLoaderError.invalidResponse
        }
            
        guard !data.isEmpty else {
            throw ImageLoaderError.InvalidImageData
        }
        
        cache.setImageData(data, for: id, option: .disk)
        return data
    }
}

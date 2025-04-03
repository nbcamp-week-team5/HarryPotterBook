import UIKit

final class ImageCache : ImageCachingService {
    private let cache = NSCache<NSString, NSData>()
    private let fileManager = FileManager.default
    private let diskCacheDirectory: URL
    
    init() {
        let cacheDirectories = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        diskCacheDirectory = cacheDirectories[0].appendingPathComponent("ImageCache")
        try? fileManager.createDirectory(at: diskCacheDirectory, withIntermediateDirectories: true)
    }
    
    func imageData(for key: String, option: CacheOption) -> Data? {
        switch option {
        case .none:
            return nil
        case .memory:
            return cache.object(forKey: key as NSString) as? Data
        case .disk:
            if let memoryImage = cache.object(forKey: key as NSString){
                return memoryImage as Data
            }
            
            let fileURL = diskCacheDirectory.appendingPathComponent(key)
            // search whether file exist in that disk cache dir
            if fileManager.fileExists(atPath: fileURL.path) {
                do {
                    let imageData = try Data(contentsOf: fileURL)
                    cache.setObject(imageData as NSData, forKey: key as NSString)
                    return imageData
                } catch {
                    print("[Error] Failed to load image from disk cache for key: \(key)")
                }
            }
        }
        return nil
    }
    
    func setImageData(_ data: Data, for key: String, option: CacheOption) {
        switch option {
        case .none:
            break
        case .memory:
            cache.setObject(data as NSData, forKey: key as NSString)
        case .disk:
            cache.setObject(data as NSData, forKey: key as NSString)
            let fileURL = diskCacheDirectory.appendingPathComponent(key)
            try? data.write(to: fileURL)
        }
    }
    
    func clearCache(option: CacheOption) {
        switch option {
        case .none:
            break
        case .memory:
            cache.removeAllObjects()
        case .disk:
            cache.removeAllObjects()
            try? fileManager.removeItem(at: diskCacheDirectory)
            try? fileManager.createDirectory(at: diskCacheDirectory, withIntermediateDirectories: true)
        }
    }
}

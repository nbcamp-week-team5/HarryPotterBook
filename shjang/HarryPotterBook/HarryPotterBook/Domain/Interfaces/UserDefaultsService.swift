import Foundation

protocol UserDefaultsService {
    func save<T>(_ value: T, forKey key: String)
    func load<T>(forKey key: String) -> T?
    func saveDict(dict: [String:Any], forKey key:String)
    func loadDict(forKey key:String) -> [String:Any]?
}

struct UserDefaultsStorageService: UserDefaultsService {
    func save<T>(_ value: T, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func load<T>(forKey key: String) -> T? {
        return UserDefaults.standard.object(forKey: key) as? T
    }
    
    func saveDict(dict: [String : Any], forKey key: String) {
        UserDefaults.standard.set(dict, forKey: key)
    }
    
    func loadDict(forKey key: String) -> [String : Any]? {
        return UserDefaults.standard.dictionary(forKey: key)
    }
}

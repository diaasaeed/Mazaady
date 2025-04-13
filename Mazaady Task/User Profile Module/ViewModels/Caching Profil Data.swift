//
//  Caching Profil Data.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 12/04/2025.
//

import Foundation


// Cache keys
enum CacheKeys {
    static let products = "cached_products"
    static let userInfo = "cached_user_info"
    static let tags = "cached_tags"
    static let ads = "cached_ads"
}

protocol DataCache {
    func save<T: Codable>(_ data: T, forKey key: String)
    func load<T: Codable>(_ type: T.Type, forKey key: String) -> T?
}

// Default implementation using UserDefaults
class UserDefaultsCache: DataCache {
    func save<T: Codable>(_ data: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func load<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
}



//
//  StorageService.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation

protocol StorageService {
    @discardableResult
    func save<T>(encodable: T, key: String) -> Bool where T: Encodable
    
    @discardableResult
    func save(properties: [String: Any], key: String) -> Bool
    
    @discardableResult
    func load(key: String) -> [String: Any]?
    
    @discardableResult
    func load<T>(key: String) -> T? where T: Decodable
}

typealias DefaultStorageService = UserDefaultStorage

class UserDefaultStorage: StorageService {
    
    private var container = UserDefaults.standard
    
    init() {}
    
    convenience init(container: UserDefaults) {
        self.init()
        self.container = container
    }
    
    //Utilisation d'une conversion en [String: Any] au lieu d'utiliser PropertyListEncoder pour la sauvegarde des Encodable
    @discardableResult
    func save<T>(encodable: T, key: String) -> Bool where T: Encodable {
        guard let encoding = try? PropertyListEncoder().encode(encodable) else {
            return false
        }
        self.container.set(encoding, forKey: key)
        self.container.synchronize()
        return true
    }
    
    @discardableResult
    func save(properties: [String: Any], key: String) -> Bool {
        let data = NSKeyedArchiver.archivedData(withRootObject: properties)
        self.container.set(data, forKey: key)
        self.container.synchronize()
        return data.count > 0
    }
    
    @discardableResult
    func load(key: String) -> [String: Any]?{
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Any]
        }
        
        return nil
    }
    
    @discardableResult
    func load<T>(key: String) -> T? where T: Decodable {
        if let data = self.container.object(forKey: key) as? Data {
            return try? PropertyListDecoder().decode(T.self, from: data)
        }
        
        return nil
    }
}

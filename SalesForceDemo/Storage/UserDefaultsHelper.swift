//
//  UserDefaultsHelper.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    static var key = Constants.userDefaultsStoreKeyForFavorites.rawValue
    
    static func saveToUserDefaults(_ key: String, value: Any) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func retrieveFromUserDefaults(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    static func removeFromUserDefaults(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}


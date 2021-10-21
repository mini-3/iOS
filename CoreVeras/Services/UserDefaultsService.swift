//
//  UserDefaultsService.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

import Foundation

public class UserDefaultsService {
    static let shared: UserDefaultsService = UserDefaultsService()
    
    private init() {}
    
    public func save(data: Any, key: String) {
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    public func retrieveDate(key: String) -> Date? {
        if let date = UserDefaults.standard.object(forKey: key) as? Date {
            return date
        }
        return nil
    }
    
}

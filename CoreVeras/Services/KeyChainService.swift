//
//  UserDefaultsService.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

import Foundation
import KeychainAccess

public class KeyChainService {
    static let shared: KeyChainService = KeyChainService()
    private let keychain: Keychain = Keychain()
    
    private init() {}
    
    public func save(data: String, key: String) -> Bool {
        guard let _ = try? keychain.set(data, key: key) else {
            return false
        }
        return true
    }
    
    public func retrieveToken(key: String) -> String? {
        if let token = try? keychain.getString(key) {
            return token
        }
        return nil
    }
    
    public func clearKey(key: String) {
        guard let _ = try? keychain.remove(key) else { return }
        
    }
    
}

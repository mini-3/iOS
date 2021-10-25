//
//  SessionService.swift
//  VerasStore
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/10/21.
//

import Foundation
import KeychainAccess

class SessionService {
    
    static let shared: SessionService = SessionService()
    var token: String = ""
    
    private init() {
        guard let token = KeyChainService.shared.retrieveToken(key: "token") else { return }
        self.token = token
    }
    
    public func logIn(cnpj: String, password: String, handler: @escaping (Bool) -> Void) {
        let body: [String: AnyHashable] = [
            "cnpj": cnpj,
            "password": password
        ]
        
        WebService.post(path: "/store_sessions", body: body, type: LogInStoreResponse.self) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let response):
                self.token = response.data.token
                let tokenSaved = KeyChainService.shared.save(data: response.data.token, key: "token")
                let cnpjSaved = KeyChainService.shared.save(data: cnpj, key: "cnpj")
                let passwordSaved = KeyChainService.shared.save(data: password, key: "password")
                UserDefaultsService.shared.save(data: Date(), key: "token_date")
                handler(tokenSaved && cnpjSaved && passwordSaved)
            case .failure(_):
                handler(false)
            }
        }
    }
    
    public func logOut() {
        self.token = ""
        KeyChainService.shared.clearKey(key: "token")
        KeyChainService.shared.clearKey(key: "password")
        KeyChainService.shared.clearKey(key: "cnpj")
        
    }
    
}

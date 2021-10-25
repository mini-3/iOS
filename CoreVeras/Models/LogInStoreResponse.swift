//
//  LogInStoreResponse.swift
//  CoreVeras
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/10/21.
//

import Foundation

struct LogInStoreDataResponse: Codable {
    let store: Store
    let token: String
}

struct LogInStoreResponse: Codable {
    let data: LogInStoreDataResponse
}

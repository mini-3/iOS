//
//  Store.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

import Foundation

struct Store: Codable {
    let id: Int
    let cnpj: String
    let name: String
    let address: String
    let email: String
    let password: String?
    let promotions: [Promotion]?
}

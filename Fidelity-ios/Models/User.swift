//
//  User.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

import Foundation

struct User: Codable {
    let id: Int
    let cpf: String
    let email: String
    let birthday: DateISO
    let password: String
}

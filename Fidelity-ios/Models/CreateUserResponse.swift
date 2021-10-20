//
//  CreateUserResponse.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 20/10/21.
//

import Foundation

struct CreateUserResponse: Codable {
    let id: Int
    let cpf: String
    let birthday: DateISO
    let password: String
}

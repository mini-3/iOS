//
//  UserSignUpRequest.swift
//  Fidelity-ios
//
//  Created by Artur Luis on 19/10/21.
//

import Foundation

struct UserSignUpRequest: Codable {
    let cpf: String
    let email: String
    let birthday: DateISO
    let password: String
}

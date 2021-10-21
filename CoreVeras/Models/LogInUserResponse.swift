//
//  LogInUserResponse.swift
//  CoreVeras
//
//  Created by Santiago del Castillo Gonzaga on 21/10/21.
//

import Foundation

struct LogInUser: Codable {
    let id: Int
    let cpf: String
    let email_user: EmailUser?
    let birthday: DateISO
    let password: String

}

struct LogInUserDataResponse: Codable {
    let user: LogInUser
    let token: String
}

struct LogInUserResponse: Codable {
    let data: LogInUserDataResponse
}

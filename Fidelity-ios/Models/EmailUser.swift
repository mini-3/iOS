//
//  EmailUser.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

import Foundation

struct EmailUser: Codable {
    let id: Int
    let email: String
    let user: User?
    let user_id: Int?
    let tickets: [Ticket]?
}

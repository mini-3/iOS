//
//  EmailUser.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

import Foundation

public struct EmailUser: Codable, Equatable {
    let id: Int
    let email: String
    let user: User?
    let user_id: Int?
    let tickets: [Ticket]?
    
    public static func ==(lhs: EmailUser, rhs: EmailUser) -> Bool {
        return lhs.id == rhs.id
    }
}

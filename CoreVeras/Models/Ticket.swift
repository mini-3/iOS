//
//  Ticket.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

import Foundation

public struct Ticket: Codable {
    let id: Int
    let isUsed: Bool
    let user: User?
    let user_id: Int?
    let promotion: Promotion?
    let promotion_id: Int?
}

//
//  Promotion.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

import Foundation

struct Promotion: Codable {
    let id: Int
    let name: String
    let code: String
    let win_ticket_amount: Int
    let award: String
    let ticket_type: String
    let start: DateISO
    let end: DateISO
    let store: Store?
    let store_id: Int?
    let tickets: [Ticket]?
}

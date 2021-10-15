//
//  UserPromotionTicketsResponse.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 14/10/21.
//

import Foundation

struct UserPromotionTicketsResponse: Codable {
    let promotion: Promotion?
    let ticketAmount: Int

    enum CodingKeys: String, CodingKey {
        case promotion
        case ticketAmount = "ticket_amount"
    }
}
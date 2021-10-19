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
<<<<<<< HEAD
=======
    let storeName: String?
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf

    enum CodingKeys: String, CodingKey {
        case promotion
        case ticketAmount = "ticket_amount"
<<<<<<< HEAD
=======
        case storeName = "store_name"
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
    }
}

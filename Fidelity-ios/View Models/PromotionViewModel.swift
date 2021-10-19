//
//  PromotionViewModel.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 13/10/21.
//

import Foundation
import UIKit

class PromotionViewModel {
    var promotion: Promotion?
    let endDateString: String
    let endDate: Date
    let award: String
    let storeName: String
    let storeDescription: String
    let storeAddress: String
    let ticketsNeeded: String
    //let storePhone: String
    //let image: UIImage
    
    init(with model: Promotion) {
        self.promotion = model
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = formatter.date(from: model.end)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        self.endDate = date ?? Date()
        self.endDateString = "Até: \(dateFormatter.string(from: date ?? Date()))"
        self.award = "Vale \(model.award)"
        self.storeName = model.store?.name ?? "Nome não encontrado"
        self.storeDescription = model.store?.description ?? "Este local não possui descrição"
        self.storeAddress = model.store?.address ?? "Este local não possui endereço disponível"
        self.ticketsNeeded = "\(model.win_ticket_amount) \(model.ticket_type)(s)"
    }
    
    func awardPhraseBuild() -> String {
        
        guard let ticketAmount = promotion?.win_ticket_amount else { return "0" }
        guard let ticketType = promotion?.ticket_type else { return "Ticket"}
        guard let award = promotion?.award else { return "Prêmio"}
        
        let answer = "Compre \(ticketAmount) \(ticketType)(s) e ganhe \(award)"
        
        return answer
    }
    
}

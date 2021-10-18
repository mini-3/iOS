//
//  PromotionViewModel.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 13/10/21.
//

import Foundation

class PromotionViewModel {
    var promotion: Promotion?
    let endDateString: String
    let endDate: Date
    
    init(with model: Promotion) {
        self.promotion = model
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = formatter.date(from: model.end)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        self.endDate = date ?? Date()
        self.endDateString = "Até: \(dateFormatter.string(from: date ?? Date()))"
    }
}

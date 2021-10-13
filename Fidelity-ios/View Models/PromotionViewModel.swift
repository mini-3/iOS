//
//  PromotionViewModel.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 13/10/21.
//

import Foundation

class PromotionViewModel {
    var promotion: Promotion?
    
    init(with model: Promotion) {
        self.promotion = model
    }
}

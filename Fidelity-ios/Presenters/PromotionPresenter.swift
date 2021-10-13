//
//  PromotionPresenter.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 13/10/21.
//

import Foundation
import UIKit

protocol PromotionPresenterDelegate: AnyObject {
    func fetched(promotions: [Promotion])
    func created(promotion: Promotion)
}

extension PromotionPresenterDelegate {
    func fetched(promotions: [Promotion]) {}
    func created(promotion: Promotion) {}
}

class PromotionPresenter {
    
    weak var view: (PromotionPresenterDelegate & UIViewController)?
    
    init() {}
    
    func createPromotion(code: String?, name: String?, award: String?, ticketType: String?, winAmount: Int?, start: Date?, end: Date?) {
        guard let code = code,
              let name = name,
              let award = award,
              let ticketType = ticketType,
              let winAmount = winAmount,
              let start = start,
              let end = end else {
                  view?.presentAlert(message: "Você precisa preencher todos os campos para criar uma promoção", title: "Oops!")
                  return
              }
        
        if winAmount < 1 {
            view?.presentAlert(message: "O total para retirar o prêmio deve ser maior que zero")
        }
        
        if end < start {
            view?.presentAlert(message: "A data do fim da promoção não pode ser antes do início ")
        }
        
        let body: [String: AnyHashable] = [
            "code": code,
            "name": name,
            "award": award,
            "ticket_type": ticketType,
            "win_ticket_amount": winAmount,
            "start": start,
            "end": end
        ]
        
        view?.presentLoadingScreen()
        WebService.post(path: "", body: body, type: Promotion.self) {[weak self] result in
            guard let self = self else {
                self?.view?.dismiss(animated: true, completion: nil)
                return
            }
            switch result {
            case .success(let promotion):
                self.view?.created(promotion: promotion)
                self.view?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error)
                self.view?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func fetchPromotions() {
        view?.presentLoadingScreen()
        WebService.get(path: "", type: [Promotion].self) {[weak self] result in
            guard let self = self else {
                self?.view?.dismiss(animated: true, completion: nil)
                return
            }
            switch result {
            case .success(let promotions):
                self.view?.fetched(promotions: promotions)
                self.view?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self.view?.dismiss(animated: true, completion: nil)
                print(error)
            }
        }
    }
}

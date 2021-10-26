//
//  PromotionPresenter.swift
//  VerasStore
//
//  Created by Pedro Gomes Rubbo Pacheco on 26/10/21.
//

import UIKit

class PromotionPresenter {
    weak var view: UIViewController?
    
    init() {}
    
    func update(promotionId: Int, name: String?, ticketType: String?, winTicketAmount: Int?, award: String?, start: Date?, end: Date?) {
        var body: [String: AnyHashable] = [:]
        
        if let name = name, !name.isEmpty {
            body["name"] = name
        }
        
        if let ticketType = ticketType, !ticketType.isEmpty {
            body["ticket_type"] = ticketType
        }

        if let winTicketAmount = winTicketAmount {
            body["win_ticket_amount"] = winTicketAmount
        }
        
        if let award = award, !award.isEmpty {
            body["award"] = award
        }
        
        if let start = start {
            body["start"] = start.toISOString()
        }

        if let end = end {
            body["end"] = end.toISOString()
        }
        
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        
        WebService.post(path: "/promotions/\(promotionId)", body: body, type: Promotion.self) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.dismiss(animated: true, completion: nil)
            }
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Promoção atualizada com sucesso", title: "Parabéns")
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Ocorreu algum erro ao atualizar promoção")
                }
            }
        }
    }
    
    func create(name: String?, ticketType: String?, winTicketAmount: Int?, award: String?, start: Date?, end: Date?, storeId: Int) {
        var body: [String: AnyHashable] = ["store_id": storeId]
        
        if let winTicketAmount = winTicketAmount {
            body["win_ticket_amount"] = winTicketAmount
        }
        
        if let name = name, !name.isEmpty {
            body["name"] = name
        }
        
        if let ticketType = ticketType, !ticketType.isEmpty {
            body["ticket_type"] = ticketType
        }

        
        if let award = award, !award.isEmpty {
            body["award"] = award
        }
        
        if let start = start {
            body["start"] = start.toISOString()
        }

        if let end = end {
            body["end"] = end.toISOString()
        }
        
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        
        WebService.post(path: "/promotions", body: body, type: Promotion.self) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.dismiss(animated: true, completion: nil)
            }
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Promoção criada com sucesso", title: "Parabéns")
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Ocorreu algum erro ao criar promoção")
                }
            }
        }
    }
    
}

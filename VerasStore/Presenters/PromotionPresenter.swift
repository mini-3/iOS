//
//  PromotionPresenter.swift
//  VerasStore
//
//  Created by Pedro Gomes Rubbo Pacheco on 26/10/21.
//

import UIKit

protocol PromotionPresenterDelegate: AnyObject {
    func fetched(promotions: [PromotionViewModel])
    func fetchedOne(promotion: PromotionViewModel)
    func updated(promotion: Promotion)
}

extension PromotionPresenterDelegate {
    func fetched(promotions: [PromotionViewModel]) {}
    func updated(promotion: Promotion) {}
    func fetchedOne(promotion: PromotionViewModel) {}
}

class PromotionPresenter {
    weak var view: (PromotionPresenterDelegate & UIViewController)?
    
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
        
        WebService.put(path: "/promotions/\(promotionId)", body: body, type: Promotion.self) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.dismiss(animated: true, completion: nil)
            }
            switch result {
            case .success(let promotion):
                DispatchQueue.main.async {
                    self.view?.updated(promotion: promotion)
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
            self.view?.presentLoadingScreen(completion: {
                WebService.post(path: "/promotions", body: body, type: Promotion.self) {[weak self] result in
                    guard let self = self else {
                        DispatchQueue.main.async {
                            self?.view?.dismiss(animated: true, completion: nil)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self.view?.dismiss(animated: true, completion: nil)
                    }
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self.view?.presentAlert(message: "Promoção criada com sucesso", title: "Parabéns")
                        }
                    case .failure(let error):
                        switch error {
                        case .APIError(let message):
                            DispatchQueue.main.async {
                                self.view?.presentAlert(message: message)
                            }
                        default:
                            DispatchQueue.main.async {
                                self.view?.presentAlert(message: "Ocorreu algum erro ao criar promoção")
                            }
                        }
                    }
                }
            })
        }
    }
    
    func fetch(withLoadingScreen: Bool) {
        if withLoadingScreen {
            DispatchQueue.main.async {
                self.view?.presentLoadingScreen(completion: {
                    WebService.get(path: "/promotions/by_store", type: [Promotion].self) {[weak self] result in
                        guard let self = self else {
                            self?.view?.dismiss(animated: true, completion: nil)
                            return
                        }
                        switch result {
                        case .success(let promotions):
                            let viewModels = promotions.sorted { $0.id < $1.id } .map { PromotionViewModel(with: $0) }
                            self.view?.fetched(promotions: viewModels)
                            DispatchQueue.main.async {
                                self.view?.dismiss(animated: true, completion: nil)
                            }
                        case .failure:
                            DispatchQueue.main.async {
                                self.view?.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                })
            }
        } else {
            WebService.get(path: "/promotions/by_store", type: [Promotion].self) {[weak self] result in
                guard let self = self else {
                    self?.view?.dismiss(animated: true, completion: nil)
                    return
                }
                switch result {
                case .success(let promotions):
                    let viewModels = promotions.sorted { $0.id < $1.id } .map { PromotionViewModel(with: $0) }
                    self.view?.fetched(promotions: viewModels)
                    DispatchQueue.main.async {
                        self.view?.dismiss(animated: true, completion: nil)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.view?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func fetchOne(withLoadingScreen: Bool, promotionId: Int) {
        if withLoadingScreen {
            DispatchQueue.main.async {
                self.view?.presentLoadingScreen()
            }
        }
        WebService.get(path: "/promotions/\(promotionId)", type: Promotion.self) {[weak self] result in
            guard let self = self else {
                self?.view?.dismiss(animated: true, completion: nil)
                return
            }
            switch result {
            case .success(let promotion):
                DispatchQueue.main.async {
                    self.view?.fetchedOne(promotion: PromotionViewModel(with: promotion))
                    self.view?.dismiss(animated: true, completion: nil)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.view?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}

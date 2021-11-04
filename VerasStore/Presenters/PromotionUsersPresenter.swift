//
//  PromotionUsersPresenter.swift
//  VerasStore
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/10/21.
//

import UIKit

protocol PromotionUsersPresenterDelegate: AnyObject {
    func fetched(tickets: [Ticket])
}

extension PromotionUsersPresenterDelegate {
    func fetched(tickets: [Ticket]) {}
}

class PromotionUsersPresenter {
    
    weak var view: (PromotionUsersPresenterDelegate & UIViewController)?
    weak var tableViewCell: (PromotionUsersPresenterDelegate & UITableViewCell)?
    
    init() {}
    
    func fetch(promotionId: Int) {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        
        WebService.get(path: "/promotion_users/\(promotionId)", type: [Ticket].self) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.dismiss(animated: true, completion: nil)
            }
            switch result {
            case .success(let tickets):
                self.view?.fetched(tickets: tickets)
                self.tableViewCell?.fetched(tickets: tickets)
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Ocorreu algum problema ao carregar os clientes!")
                }
            }
        }
    }
    
}

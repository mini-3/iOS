//
//  TicketPresenter.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 19/10/21.
//

import UIKit

protocol TicketPreseterDelegate: AnyObject {
    func created()
}

extension TicketPreseterDelegate {
    func created() {}
}

class TicketPresenter {
    
    weak var view: (TicketPreseterDelegate & UIViewController)?
    
    init() {}
    
    func create(code: String) {
        guard !code.isEmpty else {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "O seu código está vazio")
            }
            return
        }
        
        WebService.post(path: "/tickets", body: ["code": code], type: Ticket.self) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Ticket processado com sucesso", title: "Parabéns!")
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Ocorreu algum erro ao processar o ticket")
                }
            }
        }
    }
    
}

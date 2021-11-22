//
//  TicketPresenter.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 19/10/21.
//

import UIKit

protocol TicketPreseterDelegate: AnyObject {
    func created()
    func batched()
}

extension TicketPreseterDelegate {
    func created() {}
    func batched() {}
}

class TicketPresenter {
    
    weak var view: (TicketPreseterDelegate & UIViewController)?
    
    init() {}
    
    func create(code: String, email: String) {
        guard !code.isEmpty else {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "O seu código está vazio")
            }
            return
        }
        WebService.post(path: "/tickets", body: ["code": code, "email": email], type: Ticket.self) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.tabBarController?.selectedIndex = 0
            }
            switch result {
            case .success(_):
                SyncService.shared.syncTickets()
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Ticket processado com sucesso", title: "Parabéns!")
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Ocorreu algum erro ao processar o ticket")
                    //self.view?.viewDidLoad()
                }
            }
        }
    }
    
    func batch(code: String) {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        WebService.post(path: "/tickets/batch", body: ["code": code], type: TicketBatchResponse.self) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.dismiss(animated: true, completion: nil)
            }
            switch result {
            case .success(let wasCompleted):
                if wasCompleted.wasUsed {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.view?.presentAlert(message: "Você resgatou seus tickets", title: "Parabéns!")
                    }
                    self.view?.batched()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.view?.presentAlert(message: "Você ainda não tem tickets suficientes")
                    }
                }
            case .failure(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.view?.presentAlert(message: "Ocorreu algum erro ao processar os tickets")
                }
            }
        }
    }
    
}

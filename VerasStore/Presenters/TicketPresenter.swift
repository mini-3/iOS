//
//  TicketPresenter.swift
//  VerasStore
//
//  Created by Santiago del Castillo Gonzaga on 29/10/21.
//

import UIKit

protocol TicketPreseterDelegate: AnyObject {
    func batched()
}

extension TicketPreseterDelegate {
    func batched() {}
}

class TicketPresenter {
    
    weak var view: (TicketPreseterDelegate & UIViewController)?
    
    init() {}
    
    func batch(code: String, email: String) {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        WebService.post(path: "/tickets/batch", body: ["code": code, "email": email], type: TicketBatchResponse.self) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.dismiss(animated: true, completion: nil)
            }
            switch result {
            case .success(let wasCompleted):
                if wasCompleted.wasUsed {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.view?.presentAlert(message: "O cliente completou a promoção. Permita ele resgatar a recompensa!", title: "Parabéns!")
                        self.view?.viewDidLoad()
                    }
                    self.view?.batched()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.view?.presentAlert(message: "O cliente ainda não tem tickets suficientes")
                        self.view?.viewDidLoad()
                    }
                }
            case .failure(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.view?.presentAlert(message: "Ocorreu algum erro ao processar os tickets")
                    self.view?.viewDidLoad()
                }
            }
        }
    }
}


//
//  UserPresenter.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 13/10/21.
//

import Foundation
import UIKit

protocol UserPresenterDelegate: AnyObject {
    func fetched(response: [UserPromotionTicketsResponse])
}

extension UserPresenterDelegate {
    func fetched(response: [UserPromotionTicketsResponse]) {}
}

class UserPresenter {
    
    weak var view: (UserPresenterDelegate & UIViewController)?
    
    init() {}
    
    func fetchUserTicketofPromotion() {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        WebService.get(path: "/email_users/promotions", type: [UserPromotionTicketsResponse].self) {[weak self] result in
            guard let self = self else {
                self?.view?.dismiss(animated: true, completion: nil)
                return
            }
            switch result {
            case .success(let userPromotionTickets):
                self.view?.fetched(response: userPromotionTickets)
                DispatchQueue.main.async {
                    self.view?.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.dismiss(animated: true, completion: nil)
                }
                print(error)
            }
        }
    }
    
    func logIn(cpf: String?, password: String?) {
        guard let cpf = cpf,
              let password = password,
              !cpf.isEmpty && !password.isEmpty
        else {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Você precisa preencher todos os campos")
            }
            return
        }
        
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        
        SessionService.shared.logIn(cpf: cpf, password: password) {[weak self] isRegistered in
            guard let self = self else {
                DispatchQueue.main.async {
                    self?.view?.dismiss(animated: true, completion: nil)
                }
                return
            }
            DispatchQueue.main.async {
                self.view?.dismiss(animated: true, completion: nil)
            }
            if isRegistered {
                DispatchQueue.main.async {
                    let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
                    window?.rootViewController = MainTabBarViewController()
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Usuário não cadastrado")
                }
            }
            
        }
    }
    func signUp(email: String, cpf: String, password: String, confirmPassword: String, birthday: String) {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
//        let body = [["cpf":cpf], ["password":password], ["email":email],["birthday":birthday]]
//        WebService.post(path: "/users", body: body, type: <#T##(Decodable & Encodable).Protocol#>, handler: <#T##(Result<Decodable & Encodable, WebServiceError>) -> Void#>)
    }
}

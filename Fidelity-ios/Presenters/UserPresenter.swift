//
//  UserPresenter.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 13/10/21.
//

import Foundation
import UIKit

enum UserPresenterError: Error {
    case missingFields
    case userNotRegistered
}

protocol UserPresenterDelegate: AnyObject {
    func fetched(response: [UserPromotionTicketsResponse])
    func failedLogIn(error: UserPresenterError)
    func loggedIn()
}

extension UserPresenterDelegate {
    func fetched(response: [UserPromotionTicketsResponse]) {}
    func failedLogIn(error: UserPresenterError) {}
    func loggedIn() {}
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
              let password = password
        else {
            self.view?.failedLogIn(error: .missingFields)
            return
        }
        
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        
        SessionService.shared.logIn(cpf: cpf, password: password) {[weak self] isRegistered in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.dismiss(animated: true, completion: nil)
            }
            if isRegistered {
                self.view?.loggedIn()
            } else {
                self.view?.failedLogIn(error: .userNotRegistered)
            }
            
        }
    }
}

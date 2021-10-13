//
//  UserPresenter.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 13/10/21.
//

import Foundation
import UIKit

protocol UserPresenterDelegate: AnyObject {
    func fetched(users: [UserViewModel])
    func created(user: UserViewModel)
    func fetchedTicketAmount(ticketAmount: Int)
}

extension UserPresenterDelegate {
    func fetched(users: [UserViewModel]) {}
    func created(user: UserViewModel) {}
    func fetchedTicketAmount(ticketAmount: Int) {}
}

class UserPresenter {
    
    weak var view: (UserPresenterDelegate & UIViewController)?
    
    init() {}
    
    func fetchUserTicketofPromotion(emailUserId: Int, promotionId: Int) {
        view?.presentLoadingScreen()
        WebService.get(path: "", type: Int.self) {[weak self] result in
            guard let self = self else {
                self?.view?.dismiss(animated: true, completion: nil)
                return
            }
            switch result {
            case .success(let ticketAmount):
                self.view?.fetchedTicketAmount(ticketAmount: ticketAmount)
                self.view?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self.view?.dismiss(animated: true, completion: nil)
                print(error)
            }
        }
    }
    
}

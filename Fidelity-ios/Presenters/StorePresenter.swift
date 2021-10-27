//
//  StorePresenter.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 13/10/21.
//

import Foundation
import UIKit

protocol StorePresenterDelegate: AnyObject {
    func fetched(stores: [StoreViewModel])
    
}

extension StorePresenterDelegate {
    func fetched(stores: [StoreViewModel]) {}
}

class StorePresenter {
    
    weak var view: (StorePresenterDelegate & UIViewController)?
    
    init() {}
    
    func fetchStores() {
        view?.presentLoadingScreen()
        WebService.get(path: "/stores", type: [Store].self) {[weak self] result in
            guard let self = self else {
                self?.view?.dismiss(animated: true, completion: nil)
                return
            }
            switch result {
            case .success(let stores):
                let viewModels = stores.sorted { $0.id < $1.id } .map { StoreViewModel(with: $0) }
                self.view?.fetched(stores: viewModels)
                DispatchQueue.main.sync {
                    self.view?.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                DispatchQueue.main.sync {
                    self.view?.dismiss(animated: true, completion: nil)
                }
                print(error)
            }
        }
    }
    
    func logIn(cnpj: String?, password: String?) {
        guard let cnpj = cnpj,
              let password = password,
              !cnpj.isEmpty && !password.isEmpty
        else {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Você precisa preencher todos os campos")
            }
            return
        }
        
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        
//        SessionService.shared.logIn(cnpj: cnpj, password: password) {[weak self] isRegistered in
//            guard let self = self else {
//                DispatchQueue.main.async {
//                    self?.view?.dismiss(animated: true, completion: nil)
//                }
//                return
//            }
//            DispatchQueue.main.async {
//                self.view?.dismiss(animated: true, completion: nil)
//            }
//            if isRegistered {
//                DispatchQueue.main.async {
//                    let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
//                    window?.rootViewController = StorePromotionsViewController()
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.view?.presentAlert(message: "Usuário não cadastrado")
//                }
//            }
//            
//        }
    }
    
    func deleteAccount() {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        WebService.delete(path: "/stores", type: [User].self) {[weak self] result in
            guard let self = self else {
                self?.view?.dismiss(animated: true, completion: nil)
                return
            }
            switch result {
            case .success:
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
    
}

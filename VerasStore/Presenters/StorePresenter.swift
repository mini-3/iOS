//
//  StorePresenter.swift
//  VerasStore
//
//  Created by Matheus Homrich on 28/10/21.
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
            self.view?.presentLoadingScreen(completion: {
                let newCNPJ = cnpj.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "-", with: "")
                
                SessionService.shared.logIn(cnpj: newCNPJ, password: password) {[weak self] isRegistered in
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
                            let startVC = StoreMainTabBarViewController()
                            startVC.selectedIndex = 1
                            window?.rootViewController = startVC
                            
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.view?.presentAlert(message: "Usuário não cadastrado ou senha incorreta")
                        }
                    }
                }
            })
        }
        
        
    }
    
    func deleteAccount() {
        
        let id = SessionService.shared.storeId
        
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen(completion: {
                WebService.delete(path: "/stores/\(id)", type: [Store].self) {[weak self] result in
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
                        switch error {
                        case .APIError(let message):
                            DispatchQueue.main.async {
                                self.view?.presentAlert(message: message)
                            }
                        default:
                            DispatchQueue.main.async {
                                self.view?.presentAlert(message: "Ocorreu algum erro")
                            }
                        }
                    }
                }
            })
        }
       
    }
    
    func resetPassword(email: String) {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        WebService.post(path: "/store_password/forgot", body: ["email": email]) { result in
            DispatchQueue.main.async {
                self.view?.dismiss(animated: true, completion: nil)
            }
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "O email com sua nova senha foi enviado com sucesso", title: "Parabéns")
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.presentAlert(message: "Email não encontrado")
                }
            }
        }
    }
    
}

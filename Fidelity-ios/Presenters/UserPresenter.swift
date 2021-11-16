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
    
    func fetchUserTicketofPromotion(withLoadingScreen: Bool = true) {
        if withLoadingScreen {
            DispatchQueue.main.async {
                self.view?.presentLoadingScreen()
            }
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
            case .failure:
                DispatchQueue.main.async {
                    self.view?.dismiss(animated: true, completion: nil)
                }
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
            self.view?.presentLoadingScreen(completion: {
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
                            self.view?.presentAlert(message: "Usuário não cadastrado ou senha incorreta")
                        }
                    }
                    
                }
            })
        }
        
    }
    
    func signUp(email: String?, cpf: String?, password: String?, confirmPassword: String?, birthday: String?) {
        guard let email = email,
              let cpf = cpf,
              let password = password,
              let confirmPassword = confirmPassword,
              let birthday = birthday,
              !email.isEmpty && !cpf.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !birthday.isEmpty
        else {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Você precisa preencher todos os campos")
            }
            return
        }
        if password != confirmPassword {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "As senhas inseridas não são iguais.")
            }
            return
        }
        
        if !ValidatorService.validate(value: email, type: .email) {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Email inválido.")
            }
            return
        }
        if !ValidatorService.validate(value: cpf, type: .CPF) {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "CPF inválido.")
            }
            return
        }
        if !ValidatorService.validate(value: password, type: .password) {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Senha inválida.")
            }
            return
        }
        if !ValidatorService.validate(value: birthday, type: .ISOString) {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Data de nascimento inválida.")
            }
            return
        }
        
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen(completion: {
                let cpfNormalized = cpf.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
                
                let body = ["email":email, "password":password, "birthday":birthday, "cpf":cpfNormalized]
                
                WebService.post(path: "/users", body: body, type: CreateUserResponse.self) {[weak self] result in
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
                            self.view?.presentAlertWithDismissAction(title: "Parabéns!", message: "Conta criada com sucesso.")
                        }
                    case .failure(let error):
                        switch error {
                        case .badUrlError, .parsingJsonError, .noDataError:
                            DispatchQueue.main.async {
                                self.view?.presentAlert(message: "Erro ao criar conta.")
                            }
                        case .APIError(message: let message):
                            DispatchQueue.main.async {
                                self.view?.presentAlert(message: message)
                            }
                        }
                    }
                }
            })
        }
    }
    
    func deleteAccount() {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        WebService.delete(path: "/users", type: [User].self) {[weak self] result in
            guard let self = self else {
                self?.view?.dismiss(animated: true, completion: nil)
                return
            }
            switch result {
            case .success:
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
    
    func resetPassword(email: String) {
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        WebService.post(path: "/user_password/forgot", body: ["email": email]) { result in
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

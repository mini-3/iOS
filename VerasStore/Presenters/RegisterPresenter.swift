//
//  RegisterPresenter.swift
//  VerasStore
//
//  Created by Artur Luis on 03/11/21.
//

import Foundation
import UIKit


class RegisterPresenter {
    init() {}
    
    weak var view: UIViewController?
    
    func validateContinueA(_ registerModelController: RegisterStoreModelController) -> Bool {
        //email
        if !ValidatorService.validate(value: registerModelController.email, type: .email) {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Email inválido")
            }
            return false
        }
        //password size
        if !ValidatorService.validate(value: registerModelController.password, type: .password) {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Senha deve conter no mínimo 6 dígitos e no máximo 12 dígitos.")
            }
            return false
        }
        //passwords matches
        if registerModelController.password != registerModelController.confirmPassword {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "As senhas inseridas não são iguais.")
            }
            return false
        }
        
        return true
    }
    
    func validateContinueB(_ registerModelController: RegisterStoreModelController) -> Bool{
        //image
        if registerModelController.avatar == nil {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Insira uma imagem.")
            }
            return false
        }
        //company name
        if registerModelController.password.count < 1 {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Nome de empresa inválido.")
            }
            return false
        }
        
        //cnpj
        if !ValidatorService.validate(value: registerModelController.cnpj, type: .CNPJ) {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "CNPJ inválido.")
            }
            return false
        }
        //description
        if registerModelController.password.count > 50 && registerModelController.password.count < 201 {
            DispatchQueue.main.async {
                self.view?.presentAlert(message: "Descrição deve conter entre 50 a 200 caracteres.")
            }
            return false
        }
        return true
    }
    
    func validateContinueC(_ registerModelController: RegisterStoreModelController) -> Bool {
        //endereço
        return true
    }
    
    func register(_ modelController:RegisterStoreModelController, handler: @escaping () -> Void) {
        guard let image = modelController.avatar?.jpegData(compressionQuality: 1) else {
            self.view?
                .presentAlert(message: "Erro ao carregar imagem")
            return
        }
        let data = [
            "cnpj": modelController.cnpj,
            "name": modelController.name,
            "address": modelController.address,
            "password": modelController.password,
            "description": modelController.description,
            "email":modelController.email
        ]
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        MultipartService.post(path: "/stores", image: image, data: data, type: Store.self) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    print("sucess")
                    self?.view?.dismiss(animated: true)
                    handler()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("error",error)
                    self?.view?.presentAlert(message: "Erro ao registrar estabelecimento")
                }
            }
        }
    }
}
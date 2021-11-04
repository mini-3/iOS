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

    func register(_ modelController:RegisterStoreModelController, handler: @escaping () -> Void) {
        guard let image = modelController.avatar?.jpegData(compressionQuality: 0.5) else {
            self.view?
                .presentAlert(message: "Erro ao carregar imagem")
            return
        }
        let data = [
            "cnpj": modelController.cnpj,
            "name": modelController.name,
            "address": modelController.address,
            "password": modelController.password,
            "description": modelController.description
        ]
        DispatchQueue.main.async {
            self.view?.presentLoadingScreen()
        }
        MultipartService.post(path: "/stores", image: image, data: data, type: Store.self) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    print("sucess")
                    self?.view?.presentLoadingScreen()
                    handler()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    print("error")
                    self?.view?.presentAlert(message: "Erro ao registrar estabelecimento")
                }
            }
        }
    }
}

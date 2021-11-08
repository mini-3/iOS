//
//  ControllerExtensions.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 13/10/21.
//

import UIKit

extension UIViewController {
    func presentLoadingScreen(completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: "Carregando...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: completion)
        
    }
    
    func presentAlert(message: String, title: String = "Oops") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertCreateAccount() {
        let alertController = UIAlertController(title: "Parabéns!", message: "Conta criada com sucesso.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        })
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


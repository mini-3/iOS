//
//  ConfigurationViewController.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 21/10/21.
//

import Foundation
import UIKit

class ConfigurationViewController: UIViewController {
    
    private let userPresenter: UserPresenter = UserPresenter()
    
    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView()
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .vertical
        buttonStack.spacing = 8
        
        return buttonStack
    }()
    
    private lazy var logOutButton: UIButton = {
        let logOutButton = UIButton()
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.setTitle("Sair da conta", for: .normal)
        logOutButton.setTitleColor(.black, for: .normal)
        logOutButton.titleLabel?.textColor = UIColor(named: "DeleteButtonColor")
        logOutButton.backgroundColor = .white
        logOutButton.layer.cornerRadius = 20
        logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        logOutButton.titleLabel?.textAlignment = .center
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
        return logOutButton
    }()
    
    private lazy var deleteAccountButton: UIButton = {
        let deleteAccountButton = UIButton()
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAccountButton.setTitle("Deletar conta", for: .normal)
        deleteAccountButton.setTitleColor(.red, for: .normal)
        deleteAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        deleteAccountButton.titleLabel?.textAlignment = .center
        deleteAccountButton.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
        
        return deleteAccountButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Configurações"
        view.backgroundColor = UIColor(named: "Background")
        configureSubViews()
        configureConstraints()
    }
    
    func configureSubViews() {
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(deleteAccountButton)
        buttonStack.addArrangedSubview(logOutButton)
    }
    
    func configureConstraints() {
        let buttonStackContraints = [
            buttonStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 550),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ]
        
        let buttonConstraints = [
            logOutButton.heightAnchor.constraint(equalToConstant: 40),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 40)
        ]

        NSLayoutConstraint.activate(buttonStackContraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    @objc func logOut() {
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        
        let alert = UIAlertController(title: "Fazer logout?", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.default, handler: {_ in
            SessionService.shared.logOut()
            window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }))
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func deleteAccount() {
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        
        let alert = UIAlertController(title: "Alerta", message: "Você tem certeza que quer deletar sua conta?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.default, handler: {_ in
            self.userPresenter.deleteAccount()
            window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }))
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

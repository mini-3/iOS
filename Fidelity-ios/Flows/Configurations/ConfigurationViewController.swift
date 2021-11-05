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
        let button = UIStackView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.axis = .vertical
        button.spacing = 8
        
        return button
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sair da conta", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = UIColor(named: "DeleteButtonColor")
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var deleteAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Deletar conta", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSubViews()
        configureConstraints()
    }
    
    func configureUI() {
        title = "Configurações"
        view.backgroundColor = UIColor(named: "Background")
        let button = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(tappedBackButton))
        self.navigationItem.rightBarButtonItem = button
    }
    
    func configureSubViews() {
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(deleteAccountButton)
        buttonStack.addArrangedSubview(logOutButton)
    }
    
    func configureConstraints() {
        let buttonStackContraints = [
            buttonStack.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -32),
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
    
    @objc func tappedBackButton(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

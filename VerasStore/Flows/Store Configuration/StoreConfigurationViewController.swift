//
//  ConfigurationViewController.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 27/10/21.
//

import Foundation
import UIKit

class StoreConfigurationViewController: UIViewController {
    
    private let storePresenter: StorePresenter = StorePresenter()
    
    private lazy var buttonStack: UIStackView = {
        let button = UIStackView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.axis = .vertical
        button.spacing = 8
        
        return button
    }()
    
    private lazy var contactButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Contato com o suporte", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(contactSupport), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var instagramButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Siga nosso Instagram", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(goToInstagram), for: .touchUpInside)
        
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
        buttonStack.addArrangedSubview(contactButton)
        buttonStack.addArrangedSubview(instagramButton)
        buttonStack.addArrangedSubview(deleteAccountButton)
        buttonStack.addArrangedSubview(logOutButton)
    }
    
    func configureConstraints() {
        let buttonStackContraints = [
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ]
        
        let buttonConstraints = [
            contactButton.heightAnchor.constraint(equalToConstant: 40),
            instagramButton.heightAnchor.constraint(equalToConstant: 40),
            logOutButton.heightAnchor.constraint(equalToConstant: 40),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 40)
        ]

        NSLayoutConstraint.activate(buttonStackContraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    @objc func contactSupport() {
        let email = Constants.EMAIL
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func goToInstagram() {
        if let url = URL(string: "https://www.instagram.com/\(Constants.INSTAGRAM)/") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func logOut() {
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        
        let alert = UIAlertController(title: "Fazer logout?", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.default, handler: {_ in
            SessionService.shared.logOut()
            window?.rootViewController = UINavigationController(rootViewController: StoreLoginViewController())
        }))
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func deleteAccount() {
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        
        let alert = UIAlertController(title: "Alerta", message: "Você tem certeza que quer deletar sua conta?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.default, handler: {_ in
            self.storePresenter.deleteAccount()
            window?.rootViewController = UINavigationController(rootViewController: StoreLoginViewController())
        }))
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func tappedBackButton(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

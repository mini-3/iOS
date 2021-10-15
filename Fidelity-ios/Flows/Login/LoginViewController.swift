//
//  LoginViewController.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 15/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Subviews
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let emailTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.cornerRadius = 16
        return textField
    }()
    
    private let passwordTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Senha"
        textField.layer.borderWidth = 2
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.cornerRadius = 16
        return textField
    }()
    
    private let forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Esqueceu sua senha?"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let createAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ainda não tem uma conta? Cadastre-se"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        return button
    }()
    
    private let presenter = UserPresenter()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = UIColor(named: "Background")
        self.presenter.view = self
        self.addSubviews()
        self.addConstraints()
        self.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    // MARK: - Functionalities
    private func addSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(forgotPasswordLabel)
        stackView.addArrangedSubview(createAccountLabel)
        stackView.addArrangedSubview(loginButton)
    }
    
    private func addConstraints() {
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            // stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ]
        
        let buttonConstraints = [
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let textFieldsConstraints = [
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(textFieldsConstraints)
    }
    
    @objc private func didTapLogin() {
        presenter.logIn(cpf: emailTextField.text, password: passwordTextField.text)
    }
}

extension LoginViewController: UserPresenterDelegate {
    func failedLogIn(error: UserPresenterError) {
        switch error {
        case .missingFields:
            DispatchQueue.main.async {
                self.presentAlert(message: "Você precisa preencher todos os campos")
            }
        case .userNotRegistered:
            DispatchQueue.main.async {
                self.presentAlert(message: "Usuário não cadastrado")
            }
        }
    }
    
    func loggedIn() {
        DispatchQueue.main.async {
            let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
            window?.rootViewController = MainTabBarViewController()
        }
    }
}

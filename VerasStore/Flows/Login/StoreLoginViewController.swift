//
//  ConfigurationViewController.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 27/10/21.
//

import UIKit

class StoreLoginViewController: UIViewController, StorePresenterDelegate {
    
    // MARK: - Subviews
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let cnpjTextField: TextField = {
        let textField = TextField(placeholder: "CNPJ")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    private let passwordTextField: TextField = {
        let textField = TextField(placeholder: "Senha")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
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
        label.numberOfLines = 2
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
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
    
    private let presenter = StorePresenter()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = UIColor(named: "Background")
        self.presenter.view = self
        self.addSubviews()
        self.addConstraints()
        self.cnpjTextField.delegate = self
        self.passwordTextField.delegate = self
        self.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapRegister))
        createAccountLabel.isUserInteractionEnabled = true
        createAccountLabel.addGestureRecognizer(tap)
    }
    
    // MARK: - Functionalities
    private func addSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(cnpjTextField)
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
            cnpjTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(textFieldsConstraints)
    }
    
    @objc private func didTapLogin() {
        self.loginButton.pulsate()
        presenter.logIn(cnpj: cnpjTextField.text, password: passwordTextField.text)
    }
    
    @objc private func didTapRegister() {
        //let registerViewController = RegisterViewController()
        //navigationController?.pushViewController(registerViewController, animated: true)
    }
}

extension StoreLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            didTapLogin()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == cnpjTextField {
            guard let text = textField.text else { return true }
            if range.lowerBound == 2 && range.length == 0 {
                textField.text = text + "."
            }

            if range.lowerBound == 6 && range.length == 0 {
                textField.text = text + "."
            }

            if range.lowerBound == 10 && range.length == 0 {
                textField.text = text + "/"
            }
            
            if range.lowerBound == 15 && range.length == 0 {
                textField.text = text + "-"
            }

            let newLength = text.count + string.count - range.length
            return newLength <= 18
        }
        return true
    }
    
}

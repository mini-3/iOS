//
//  RegisterViewController.swift
//  VerasStore
//
//  Created by Artur Luis on 28/10/21.
//

import Foundation
import UIKit

class RegisterAViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let emailTextField: TextField = {
        let textField = TextField(placeholder: "Email")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: TextField = {
        let textField = TextField(placeholder: "Senha")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let confirmPasswordField: TextField = {
        let textField = TextField(placeholder: "Confirmar Senha")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        return button
    }()
    
    var registerPresenter = RegisterPresenter()
    var registerModelController = RegisterStoreModelController()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Criar conta (1/3)"
        setInputFirstValues()
        addSubviews()
        addConstraints()
        self.registerPresenter.view = self
        self.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordField.delegate = self
    }
    
    private func addSubviews() {
        view?.addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordField)
        stackView.addArrangedSubview(continueButton)
    }
    
    private func addConstraints() {
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ]
        
        let textFieldConstraints = [
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        let buttonConstraints = [
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    @objc func didTapContinue() {
        registerModelController.email = emailTextField.text ?? ""
        registerModelController.password = passwordTextField.text ?? ""
        registerModelController.confirmPassword = confirmPasswordField.text ?? ""
        
        if registerPresenter.validateContinueA(registerModelController) {
            let registerBViewController = RegisterBViewController()
            registerBViewController.configure(modelController: registerModelController)
            navigationController?.pushViewController(registerBViewController, animated: true)
        }
    }
    
    func setInputFirstValues() {
        emailTextField.text = registerModelController.email
        passwordTextField.text = registerModelController.password
        confirmPasswordField.text = registerModelController.confirmPassword
    }
}

extension RegisterAViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.confirmPasswordField.becomeFirstResponder()
        case self.confirmPasswordField:
            didTapContinue()
        default:
            self.confirmPasswordField.becomeFirstResponder()
        }
    }

}

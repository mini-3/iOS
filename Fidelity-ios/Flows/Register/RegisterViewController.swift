//
//  RegisterViewController.swift
//  Fidelity-ios
//
//  Created by Artur Luis on 18/10/21.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        view.bindToKeyboard()
        addSubviews()
        addConstraint()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSignIn))
        signInLabel.isUserInteractionEnabled = true
        signInLabel.addGestureRecognizer(tap)
    }
    
    private func addSubviews(){
        view.addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(cpfTextField)
        stackView.addArrangedSubview(birthdayDatePicker)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordField)
        stackView.addArrangedSubview(signInLabel)
        stackView.addArrangedSubview(continueButton)
    }
    
    private func addConstraint() {
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ]
        
        let textFieldConstraints = [
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            cpfTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 40),
            signInLabel.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let buttonConstraints = [
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    
    @objc private func didTapSignIn() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - Views
    
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
        return textField
    }()
    
    private let cpfTextField: TextField = {
        let textField = TextField(placeholder: "CPF")
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tem uma conta? Entre!"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    private let birthdayDatePicker: UIView = {
        let datePicker = DatePicker(label: "Birthday")
        return datePicker
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
    
}

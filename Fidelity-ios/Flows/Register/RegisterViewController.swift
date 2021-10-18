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
        
    }
    
    private func addSubviews(){
        view.addSubview(stackView)
//        stackView.addArrangedSubview(emailTextField)
//        stackView.addArrangedSubview(cpfTextField)
//        stackView.addArrangedSubview(passwordTextField)
//        stackView.addArrangedSubview(confirmPasswordField)
    }
    
    private func addConstraint() {
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            // stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
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
    
}

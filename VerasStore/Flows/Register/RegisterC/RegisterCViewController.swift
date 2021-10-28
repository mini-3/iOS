//
//  RegisterViewController.swift
//  VerasStore
//
//  Created by Artur Luis on 28/10/21.
//

import Foundation
import UIKit

class RegisterCViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let cepTextField: TextField = {
        let textField = TextField(placeholder: "CEP")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()

    private let streetTextField: TextField = {
        let textField = TextField(placeholder: "Rua")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let neighboutTextField: TextField = {
        let textField = TextField(placeholder: "Bairro")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let numberTextField: TextField = {
        let textField = TextField(placeholder: "num")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let complementTextField: TextField = {
        let textField = TextField(placeholder: "complemento")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
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
    
    private func addSubviews() {
        view?.addSubview(stackView)
        stackView.addArrangedSubview(cepTextField)
        stackView.addArrangedSubview(streetTextField)
        stackView.addArrangedSubview(neighboutTextField)
        stackView.addArrangedSubview(numberTextField)
        stackView.addArrangedSubview(complementTextField)
    }
    
    private func addConstraints() {
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ]
        
        let textFieldConstraints = [
            cepTextField.heightAnchor.constraint(equalToConstant: 40),
            streetTextField.heightAnchor.constraint(equalToConstant: 40),
            neighboutTextField.heightAnchor.constraint(equalToConstant: 40),
            numberTextField.heightAnchor.constraint(equalToConstant: 40),
            complementTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let buttonConstraints = [
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    override func viewDidLoad() {
        addSubviews()
        addConstraints()
    }
    
    
}

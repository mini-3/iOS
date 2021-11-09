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
    
    private let addressTextField: TextField = {
        let textField = TextField(placeholder: "Endereço")
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
    
    var registerPresenter = RegisterPresenter()
    var registerModelController: RegisterStoreModelController? = nil
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Criar conta (3/3)"
        addSubviews()
        addConstraints()
        self.registerPresenter.view = self
        self.addressTextField.delegate = self
        self.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view?.addSubview(stackView)
        stackView.addArrangedSubview(addressTextField)
        stackView.addArrangedSubview(continueButton)
    }
    
    private func addConstraints() {
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ]
        
        let textFieldConstraints = [
            addressTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let buttonConstraints = [
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    @objc func didTapContinue() {
        registerModelController?.address = addressTextField.text ?? ""
        
        if let registerModelController = registerModelController, registerPresenter.validateContinueC(registerModelController) {
            registerPresenter.register(registerModelController) {
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
  
    public func configure(modelController: RegisterStoreModelController) {
        registerModelController = modelController
    }
}

extension RegisterCViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addressTextField {
            didTapContinue()
        }
        return true
    }
}

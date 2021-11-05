//
//  RegisterViewController.swift
//  VerasStore
//
//  Created by Artur Luis on 28/10/21.
//

import Foundation
import UIKit

class RegisterCViewController: UIViewController {
    var registerPresenter = RegisterPresenter()
    var registerModelController: RegisterStoreModelController? = nil
    
    public func configure(modelController: RegisterStoreModelController) {
        registerModelController = modelController
    }
    
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
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Background")
        addSubviews()
        addConstraints()
        self.registerPresenter.view = self
        self.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }
    
    @objc func didTapContinue() {
        guard var registerModelController = registerModelController else { return }
        registerModelController.address = addressTextField.text ?? ""
        print(registerModelController)
        registerPresenter.register(registerModelController) {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

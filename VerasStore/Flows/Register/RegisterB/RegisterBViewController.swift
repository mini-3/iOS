//
//  RegisterViewController.swift
//  VerasStore
//
//  Created by Artur Luis on 28/10/21.
//

import Foundation
import UIKit
import UniformTypeIdentifiers

class RegisterBViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let addAvatarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Adicionar Avatar", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        return button
    }()
    
    private let companyNameTextField: TextField = {
        let textField = TextField(placeholder: "Nome da empresa")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let userNameTextField: TextField = {
        let textField = TextField(placeholder: "Seu nome")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continuar", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        return button
    }()
    
    private func addSubviews() {
        view?.addSubview(stackView)
        stackView.addArrangedSubview(addAvatarButton)
        stackView.addArrangedSubview(companyNameTextField)
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(continueButton)
        
    }
    
    private func addConstraints() {
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ]
        
        let textFieldConstraints = [
            companyNameTextField.heightAnchor.constraint(equalToConstant: 40),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let buttonConstraints = [
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            addAvatarButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Background")
        addSubviews()
        addConstraints()
        self.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        self.addAvatarButton.addTarget(self, action: #selector(didTapAddAvatar), for: .touchUpInside)
    }
    
    @objc func didTapContinue() {
        let registerCViewController = RegisterCViewController()
        navigationController?.pushViewController(registerCViewController, animated: true)
    }
    
    @objc func didTapAddAvatar() {
        if #available(iOS 14.0, *) {
            let supportedTypes = [UTType.image]
            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false
            documentPicker.shouldShowFileExtensions = true
            present(documentPicker, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension RegisterBViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {}
}
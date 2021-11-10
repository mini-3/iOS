//
//  RegisterViewController.swift
//  VerasStore
//
//  Created by Artur Luis on 28/10/21.
//

import Foundation
import UIKit

class RegisterCViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "logoname")
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let telephoneTextField: TextField = {
        let textField = TextField(placeholder: "Telefone")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.keyboardType = .phonePad
        return textField
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
        self.telephoneTextField.delegate = self
        self.addressTextField.delegate = self
        self.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view?.addSubview(stackView)
        stackView.addArrangedSubview(telephoneTextField)
        stackView.addArrangedSubview(addressTextField)
        stackView.addArrangedSubview(continueButton)
    }
    
    private func addConstraints() {
        
        let logoImageViewConstraints = [
            logoImageView.heightAnchor.constraint(equalToConstant: 270),
            logoImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 48),
            logoImageView.widthAnchor.constraint(equalToConstant: 160),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ]
        
        let textFieldConstraints = [
            telephoneTextField.heightAnchor.constraint(equalToConstant: 40),
            addressTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let buttonConstraints = [
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(logoImageViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    @objc func didTapContinue() {
        registerModelController?.address = addressTextField.text ?? ""
        registerModelController?.telephone = telephoneTextField.text ?? ""
        
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
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.telephoneTextField:
            let _ = self.addressTextField.becomeFirstResponder()
        case self.addressTextField:
            didTapContinue()
        default:
            let _ = self.addressTextField.becomeFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == telephoneTextField {
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "(XX) XXXXX-XXXX", phone: newString)
        }
        if textField == addressTextField {
            return true
        }
        return false
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])

                index = numbers.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
}

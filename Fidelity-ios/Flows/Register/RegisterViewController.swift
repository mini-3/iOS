//
//  RegisterViewController.swift
//  Fidelity-ios
//
//  Created by Artur Luis on 18/10/21.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController, UserPresenterDelegate {
    
    //MARK: - Subviews
    
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
    
    private let cpfTextField: TextField = {
        let textField = TextField(placeholder: "CPF")
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
    
    private let birthdayDatePicker: DatePicker = {
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
    
    private let presenter = UserPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.view = self
        self.addSubviews()
        self.addConstraint()
        self.configureUI()
        
        self.emailTextField.delegate = self
        self.cpfTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordField.delegate = self
    }
    
    private func configureUI() {
        title = "Criar conta"
        view.backgroundColor = UIColor(named: "Background")
        
        continueButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
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
    
    @objc private func didTapSignUp() {
        let email = emailTextField.text
        let cpf = cpfTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordField.text
        let birthday = birthdayDatePicker.picker.date.toISOString()
        
        presenter.signUp(email: email, cpf: cpf, password: password, confirmPassword: confirmPassword, birthday: birthday)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == cpfTextField {
            guard let text = textField.text else { return true }
            if range.lowerBound == 3 && range.length == 0 {
                textField.text = text + "."
            }
            
            if range.lowerBound == 7 && range.length == 0 {
                textField.text = text + "."
            }
            
            if range.lowerBound == 11 && range.length == 0 {
                textField.text = text + "-"
            }
            
            let newLength = text.count + string.count - range.length
            return newLength <= 14
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            self.cpfTextField.becomeFirstResponder()
        case self.cpfTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.confirmPasswordField.becomeFirstResponder()
        case self.confirmPasswordField:
            didTapSignUp()
        default:
            self.confirmPasswordField.becomeFirstResponder()
        }
    }
}

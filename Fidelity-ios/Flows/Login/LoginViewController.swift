//
//  LoginViewController.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 15/10/21.
//

import UIKit

class LoginViewController: UIViewController, UserPresenterDelegate {
    
    // MARK: - Subviews
    private var resetEmailTextField: UITextField = {
        let textField = TextField(placeholder: "Email")
        textField.keyboardType = .emailAddress
        
        return textField
    }()
    
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
    
    private let presenter = UserPresenter()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.view = self
        self.addSubviews()
        self.addConstraints()
        self.configureUI()
        
        self.cpfTextField.delegate = self
        self.passwordTextField.delegate = self
        
    }
    
    // MARK: - Functionalities
    private func configureUI() {
        title = "Login"
        view.backgroundColor = UIColor(named: "Background")
        
        self.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapRegister))
        createAccountLabel.isUserInteractionEnabled = true
        createAccountLabel.addGestureRecognizer(tap)
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(cpfTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(forgotPasswordLabel)
        stackView.addArrangedSubview(createAccountLabel)
        stackView.addArrangedSubview(loginButton)
        let resetPasswordTap = UITapGestureRecognizer(target: self, action: #selector(didTapForgotPassword))
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.addGestureRecognizer(resetPasswordTap)
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
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
        ]
        
        let buttonConstraints = [
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let textFieldsConstraints = [
            cpfTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(logoImageViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(textFieldsConstraints)
    }
    
    private func displayForm(message:String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel" , style: .cancel)
        
        let saveAction = UIAlertAction(title: "Submit", style: .default) { (action) -> Void in
            guard let text = self.resetEmailTextField.text else { return }
            self.presenter.resetPassword(email: text)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Email..."
            self.resetEmailTextField = textField
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapForgotPassword(){
        self.displayForm(message: "Resetando a senha")
    }
    
    @objc private func didTapLogin() {
        self.loginButton.pulsate()
        presenter.logIn(cpf: cpfTextField.text, password: passwordTextField.text)
    }
    
    @objc private func didTapRegister() {
        let registerViewController = RegisterViewController()
        
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            didTapLogin()
        }
        return true
    }
    
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
    
}

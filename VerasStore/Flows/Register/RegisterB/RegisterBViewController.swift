//
//  RegisterViewController.swift
//  VerasStore
//
//  Created by Artur Luis on 28/10/21.
//

import Foundation
import UIKit
import UniformTypeIdentifiers
import Kingfisher

class RegisterBViewController: UIViewController, UINavigationControllerDelegate {
    var registerPresenter = RegisterPresenter()
    var registerModelController:RegisterStoreModelController? = nil
    
    public func configure(modelController: RegisterStoreModelController) {
        registerModelController = modelController
    }
    
    private let imagePicker = UIImagePickerController()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
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
    
    private let cnpjTextField: TextField = {
        let textField = TextField(placeholder: "CNPJ")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let companyNameTextField: TextField = {
        let textField = TextField(placeholder: "Nome da empresa")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let descriptionTextField: TextField = {
        let textField = TextField(placeholder: "Descrição")
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
        view.addSubview(avatarImage)
        view.addSubview(stackView)
        stackView.addArrangedSubview(addAvatarButton)
        stackView.addArrangedSubview(companyNameTextField)
        stackView.addArrangedSubview(cnpjTextField)
        stackView.addArrangedSubview(descriptionTextField)
        stackView.addArrangedSubview(continueButton)
        
    }
    
    private func addConstraints() {
        let imageViewConstraints = [
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -64),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            avatarImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor, multiplier: 1)
        ]
        
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ]
        
        let textFieldConstraints = [
            companyNameTextField.heightAnchor.constraint(equalToConstant: 40),
            cnpjTextField.heightAnchor.constraint(equalToConstant: 40),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        let buttonConstraints = [
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            addAvatarButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Background")
        setInputFirstValues()
        addSubviews()
        addConstraints()
        self.registerPresenter.view = self
        self.cnpjTextField.delegate = self
        imagePicker.delegate = self
        self.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        self.addAvatarButton.addTarget(self, action: #selector(didTapAddAvatar), for: .touchUpInside)
    }
    
    @objc func didTapContinue() {
        registerModelController?.name = companyNameTextField.text ?? ""
        registerModelController?.cnpj = (cnpjTextField.text ?? "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "-", with: "")
        registerModelController?.description = descriptionTextField.text ?? ""
        registerModelController?.avatar = avatarImage.image
        
        if let registerModelController = registerModelController , registerPresenter.validateContinueB(registerModelController) {
            let registerCViewController = RegisterCViewController()
            registerCViewController.configure(modelController: registerModelController)
            navigationController?.pushViewController(registerCViewController, animated: true)
        }
    }
    
    @objc func didTapAddAvatar() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func setInputFirstValues() {
        companyNameTextField.text = registerModelController?.name ?? ""
    }
}

extension RegisterBViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        self.avatarImage.kf.setImage(with: urls[0])
    }
}
extension RegisterBViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.avatarImage.image = image
            
        }
        self.imagePicker.dismiss(animated: true) {}
    }
}

extension RegisterBViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == cnpjTextField {
            guard let text = textField.text else { return true }
            if range.lowerBound == 2 && range.length == 0 {
                textField.text = text + "."
            }
            
            if range.lowerBound == 6 && range.length == 0 {
                textField.text = text + "."
            }
            
            if range.lowerBound == 10 && range.length == 0 {
                textField.text = text + "/"
            }
            
            if range.lowerBound == 15 && range.length == 0 {
                textField.text = text + "-"
            }
            
            let newLength = text.count + string.count - range.length
            return newLength <= 18
        }
        return true
    }
    
}

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
    
    private let companyNameTextField: TextField = {
        let textField = TextField(placeholder: "Nome da empresa")
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
            companyNameTextField.heightAnchor.constraint(equalToConstant: 40)
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
        imagePicker.delegate = self
        self.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        self.addAvatarButton.addTarget(self, action: #selector(didTapAddAvatar), for: .touchUpInside)
    }
    
    @objc func didTapContinue() {
        registerModelController?.name = companyNameTextField.text ?? ""
        registerModelController?.avatar = avatarImage.image
        
        let registerCViewController = RegisterCViewController()
        guard let registerModelController = registerModelController else {return }
        registerCViewController.configure(modelController: registerModelController)
        navigationController?.pushViewController(registerCViewController, animated: true)
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
        //        self.picker.dismiss(animated: true, completion: nil)
    }
}

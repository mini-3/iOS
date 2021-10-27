//
//  GenerateQrCodeViewController.swift
//  VerasStore
//
//  Created by Santiago del Castillo Gonzaga on 26/10/21.
//

import Foundation
import UIKit

class GenerateTicketViewController: UIViewController {
    
    //MARK: - SubViews
    private var qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var addCustomerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Adicionar cliente por email", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(addCustomer), for: .touchUpInside)
        
        return button
    }()
    
    var promotion: PromotionViewModel?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureSubViews()
        self.configureConstraints()
    }
    
    //MARK: - Funcionalities
    func configureUI() {
        view.backgroundColor = UIColor(named: "Background")
        
        guard let promotion = promotion else { return }
        title = promotion.award
        navigationController?.navigationBar.prefersLargeTitles = false
        qrCodeImageView.image = QRcodeService.shared.generateQRCode(from: "qrCode")
    }
    
    func configureSubViews() {
        view.addSubview(qrCodeImageView)
        view.addSubview(addCustomerButton)
    }
    
    func configureConstraints() {
        let qrCodeImageViewConstraints = [
            qrCodeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            qrCodeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrCodeImageView.heightAnchor.constraint(equalToConstant: 200),
            qrCodeImageView.widthAnchor.constraint(equalToConstant: 200)
        ]
        
        let addCustomerButtonConstraints = [
            addCustomerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            addCustomerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            addCustomerButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16),
            addCustomerButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(qrCodeImageViewConstraints)
        NSLayoutConstraint.activate(addCustomerButtonConstraints)
    }
    
    //MARK: - Objc
    @objc func addCustomer(sender: UIButton) {
        let alert = UIAlertController(title: "Adicionar ticket por email", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Digite o email"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
             
            guard let textField = alert?.textFields?[0] else { return }// Force unwrapping because we know it exists.
            print(textField.text ?? "erro")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  StoreDetailsViewController.swift
//  Fidelity-ios
//
//  Created by Santiago del Castillo Gonzaga on 14/10/21.
//

import Foundation
import UIKit

class StoreDetailsViewController: UIViewController {
    
    private lazy var storeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        label.font = UIFont(name: "SFProText-Bold", size: 34)
        label.textColor = .label
        label.numberOfLines = 1
=======
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "Nome do estabelecimento"
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        
        return label
    }()
    
    private lazy var detailsStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .gray
        label.numberOfLines = 0
=======
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "secondaryLabel")
        label.numberOfLines = 0
        label.text = "Detalhes do estabelecimento"
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        
        return label
    }()
    
    private var verticalStoreInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private var verticalAddressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .gray
=======
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "secondaryLabel")
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        label.numberOfLines = 1
        label.text = "Endereço:"
        
        return label
    }()
    
    private lazy var addressStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        label.font = UIFont(name: "SFProText-SemiBold", size: 13)
        label.textColor = .label
        label.numberOfLines = 0
=======
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Endereço do estabelecimento"
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        
        return label
    }()
    
    private var verticalTelephoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var telephoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .gray
=======
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "secondaryLabel")
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        label.numberOfLines = 1
        label.text = "Telefone:"
        
        return label
    }()
    
    private lazy var telephoneStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        label.font = UIFont(name: "SFProText-SemiBold", size: 13)
        label.textColor = .label
        label.numberOfLines = 1
=======
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "Telefone do estabelecimento"
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        
        return label
    }()
    
    private lazy var promotionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "StoreCell")
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private var verticalPromotionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private var verticalRequirementsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var requirementsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .gray
=======
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "secondaryLabel")
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        label.numberOfLines = 1
        label.text = "Requisitos:"
        
        return label
    }()
    
    private lazy var requirementsStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        label.font = UIFont(name: "SFProText-SemiBold", size: 13)
        label.textColor = .label
        label.numberOfLines = 0
=======
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Requisitos da promoção"
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        
        return label
    }()
    
    private var verticalRewardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var rewardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .gray
=======
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "secondaryLabel")
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        label.numberOfLines = 1
        label.text = "Recompensa:"
        
        return label
    }()
    
    private lazy var rewardStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
<<<<<<< HEAD
        label.font = UIFont(name: "SFProText-SemiBold", size: 13)
        label.textColor = .label
        label.numberOfLines = 0
=======
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Recompensa da promoção"
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        
        return label
    }()
    
    private lazy var storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        self.configureSubViews()
        self.configureStacks()
        self.configureConstraints()
    }
    
    func configureView() {
        view.backgroundColor = UIColor(named: "Background")
<<<<<<< HEAD
=======
        storeLabel.text = "Brizza Pizzaria"
        detailsStoreLabel.text = "Descrição breve do estabelecimento. Podemos dar ideias no app da empresa de coisas legais"
        addressStoreLabel.text = "24 de Outubro, Moinhos de vento. Porto Alegre"
        telephoneStoreLabel.text = "(51)99999-9999"
        requirementsStoreLabel.text = "Comprar 10 pizzas"
        rewardStoreLabel.text = "Uma pizza grátis"
        storeImageView.image = UIImage(named: "photo")
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
    }
    
    func configureSubViews() {
        view.addSubview(storeLabel)
        view.addSubview(detailsStoreLabel)
        view.addSubview(verticalStoreInfoStackView)
        view.addSubview(promotionView)
        promotionView.addSubview(verticalPromotionStackView)
        view.addSubview(storeImageView)
    }
    
    func configureStacks() {
        verticalStoreInfoStackView.addArrangedSubview(verticalAddressStackView)
        verticalStoreInfoStackView.addArrangedSubview(verticalTelephoneStackView)
        verticalAddressStackView.addArrangedSubview(addressLabel)
        verticalAddressStackView.addArrangedSubview(addressStoreLabel)
        verticalTelephoneStackView.addArrangedSubview(telephoneLabel)
        verticalTelephoneStackView.addArrangedSubview(telephoneStoreLabel)
        verticalPromotionStackView.addArrangedSubview(verticalRequirementsStackView)
        verticalPromotionStackView.addArrangedSubview(verticalRewardStackView)
        verticalRequirementsStackView.addArrangedSubview(requirementsLabel)
        verticalRequirementsStackView.addArrangedSubview(requirementsStoreLabel)
        verticalRewardStackView.addArrangedSubview(rewardLabel)
        verticalRewardStackView.addArrangedSubview(rewardStoreLabel)
    }
    
    func configureConstraints() {
        let storeLabelConstraints = [
            storeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            storeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
<<<<<<< HEAD
            storeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 4)
=======
            storeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64)
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        ]
        
        let storeDetailsLabelConstraints = [
            detailsStoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailsStoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
<<<<<<< HEAD
            detailsStoreLabel.topAnchor.constraint(equalTo: storeLabel.bottomAnchor, constant: 8)
        ]
        
        let storeInfoStackViewConstraints = [
            verticalStoreInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            verticalStoreInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            verticalStoreInfoStackView.topAnchor.constraint(equalTo: detailsStoreLabel.bottomAnchor, constant: 8)
        ]
        
        let addressStackViewConstraints = [
            verticalAddressStackView.leadingAnchor.constraint(equalTo: verticalStoreInfoStackView.leadingAnchor, constant: 6),
            verticalAddressStackView.trailingAnchor.constraint(equalTo: verticalStoreInfoStackView.trailingAnchor, constant: -6)
        ]
        
        let telephoneStackViewConstraints = [
            verticalTelephoneStackView.leadingAnchor.constraint(equalTo: verticalStoreInfoStackView.leadingAnchor, constant: 6),
            verticalTelephoneStackView.trailingAnchor.constraint(equalTo: verticalStoreInfoStackView.trailingAnchor, constant: -6)
        ]
        
        let promotionViewConstraints = [
            promotionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            promotionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let promotionStackViewConstraints = [
            verticalPromotionStackView.leadingAnchor.constraint(equalTo: promotionView.leadingAnchor, constant: 0),
            verticalRequirementsStackView.trailingAnchor.constraint(equalTo: promotionView.trailingAnchor, constant: 0)
        ]
        
        let requirementsStackViewConstraints = [
            verticalRequirementsStackView.leadingAnchor.constraint(equalTo: verticalPromotionStackView.leadingAnchor, constant: 6),
            verticalRequirementsStackView.trailingAnchor.constraint(equalTo: verticalPromotionStackView.trailingAnchor, constant: -6)
        ]
        
        let rewarsStackViewConstraints = [
            verticalRewardStackView.leadingAnchor.constraint(equalTo: verticalPromotionStackView.leadingAnchor, constant: 6),
            verticalRewardStackView.trailingAnchor.constraint(equalTo: verticalPromotionStackView.trailingAnchor, constant: -6)
        ]
        
        let storeImageViewConstraints = [
            storeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            storeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            storeImageView.topAnchor.constraint(equalTo: promotionView.bottomAnchor, constant: 20)
=======
            detailsStoreLabel.topAnchor.constraint(equalTo: storeLabel.bottomAnchor, constant: 32)
        ]

        let storeInfoStackViewConstraints = [
            verticalStoreInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            verticalStoreInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            verticalStoreInfoStackView.topAnchor.constraint(equalTo: detailsStoreLabel.bottomAnchor, constant: 20)
        ]

        let promotionViewConstraints = [
            promotionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            promotionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            promotionView.topAnchor.constraint(equalTo: verticalStoreInfoStackView.bottomAnchor, constant: 20)
        ]

        let promotionStackViewConstraints = [
            verticalPromotionStackView.leadingAnchor.constraint(equalTo: promotionView.leadingAnchor, constant: 16),
            verticalPromotionStackView.trailingAnchor.constraint(equalTo: promotionView.trailingAnchor, constant: -16),
            verticalPromotionStackView.topAnchor.constraint(equalTo: promotionView.topAnchor, constant: 10),
            verticalRewardStackView.bottomAnchor.constraint(equalTo: promotionView.bottomAnchor, constant: -10)
        ]

        let storeImageViewConstraints = [
            storeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            storeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            storeImageView.topAnchor.constraint(equalTo: promotionView.bottomAnchor, constant: 32),
            storeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        ]
        
        NSLayoutConstraint.activate(storeLabelConstraints)
        NSLayoutConstraint.activate(storeDetailsLabelConstraints)
        NSLayoutConstraint.activate(storeInfoStackViewConstraints)
<<<<<<< HEAD
        NSLayoutConstraint.activate(addressStackViewConstraints)
        NSLayoutConstraint.activate(telephoneStackViewConstraints)
        NSLayoutConstraint.activate(promotionViewConstraints)
        NSLayoutConstraint.activate(promotionStackViewConstraints)
        NSLayoutConstraint.activate(requirementsStackViewConstraints)
        NSLayoutConstraint.activate(rewarsStackViewConstraints)
        NSLayoutConstraint.activate(storeImageViewConstraints)
    }
}
=======
        NSLayoutConstraint.activate(promotionViewConstraints)
        NSLayoutConstraint.activate(promotionStackViewConstraints)
        NSLayoutConstraint.activate(storeImageViewConstraints)
    }
}

>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
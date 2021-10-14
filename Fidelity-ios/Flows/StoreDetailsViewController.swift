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
        label.font = UIFont(name: "SFProText-Bold", size: 34)
        label.textColor = .label
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var detailsStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(red: 196, green: 196, blue: 196, alpha: 1)
        label.numberOfLines = 0
        
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
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(red: 196, green: 196, blue: 196, alpha: 1)
        label.numberOfLines = 1
        label.text = "Endereço:"
        
        return label
    }()
    
    private lazy var addressStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-SemiBold", size: 13)
        label.textColor = .label
        label.numberOfLines = 0
        
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
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(red: 196, green: 196, blue: 196, alpha: 1)
        label.numberOfLines = 1
        label.text = "Telefone:"
        
        return label
    }()
    
    private lazy var telephoneStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-SemiBold", size: 13)
        label.textColor = .label
        label.numberOfLines = 1
        
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
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(red: 196, green: 196, blue: 196, alpha: 1)
        label.numberOfLines = 1
        label.text = "Requisitos:"
        
        return label
    }()
    
    private lazy var requirementsStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-SemiBold", size: 13)
        label.textColor = .label
        label.numberOfLines = 0
        
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
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(red: 196, green: 196, blue: 196, alpha: 1)
        label.numberOfLines = 1
        label.text = "Recompensa:"
        
        return label
    }()
    
    private lazy var rewardStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-SemiBold", size: 13)
        label.textColor = .label
        label.numberOfLines = 0
        
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
        configureView()
        configureSubViews()
        configureStacks()
        configureConstraints()
    }
    
    func configureView() {
        view.backgroundColor = UIColor(named: "Background")
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
            storeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 4)
        ]
        
        let storeDetailsLabelConstraints = [
            detailsStoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailsStoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
        ]
        
        NSLayoutConstraint.activate(storeLabelConstraints)
        NSLayoutConstraint.activate(storeDetailsLabelConstraints)
        NSLayoutConstraint.activate(storeInfoStackViewConstraints)
        NSLayoutConstraint.activate(addressStackViewConstraints)
        NSLayoutConstraint.activate(telephoneStackViewConstraints)
        NSLayoutConstraint.activate(promotionViewConstraints)
        NSLayoutConstraint.activate(promotionStackViewConstraints)
        NSLayoutConstraint.activate(requirementsStackViewConstraints)
        NSLayoutConstraint.activate(rewarsStackViewConstraints)
        NSLayoutConstraint.activate(storeImageViewConstraints)
    }
}

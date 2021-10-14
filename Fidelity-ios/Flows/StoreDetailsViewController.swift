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
    
    private var verticalAdressTelephoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private var verticalAdressStackView: UIStackView = {
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
        
        return label
    }()
    
    private lazy var requirementsStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        return label
    }()
    
    private lazy var rewardStoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        view.addSubview(verticalAdressTelephoneStackView)
        view.addSubview(promotionView)
        promotionView.addSubview(verticalPromotionStackView)
        view.addSubview(storeImageView)
    }
    
    func configureStacks() {
        verticalAdressTelephoneStackView.addArrangedSubview(verticalAdressStackView)
        verticalAdressTelephoneStackView.addArrangedSubview(verticalTelephoneStackView)
        verticalAdressStackView.addArrangedSubview(addressLabel)
        verticalAdressStackView.addArrangedSubview(addressStoreLabel)
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
        
    }
}

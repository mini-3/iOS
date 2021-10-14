//
//  StoresTableViewCell.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 14/10/21.
//

import Foundation
import UIKit

class StoresTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: self)
    
    private lazy var storeImageView: UIImageView = {
        let storeImageView = UIImageView()
        storeImageView.translatesAutoresizingMaskIntoConstraints = false
        storeImageView.circleImage()
        return storeImageView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        
        return horizontalStackView
    }()
    
    private lazy var storeNameDescriptionStackView: UIStackView = {
        let storeNameDescriptionStackView = UIStackView()
        storeNameDescriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        storeNameDescriptionStackView.axis = .vertical
        storeNameDescriptionStackView.spacing = 8
        
        return storeNameDescriptionStackView
    }()
    
    private lazy var storeName: UILabel = {
        let storeName = UILabel()
        storeName.translatesAutoresizingMaskIntoConstraints = false
        
        return storeName
    }()
    
    private lazy var storePromotionDescription: UILabel = {
        let storePromotionDescription = UILabel()
        storePromotionDescription.translatesAutoresizingMaskIntoConstraints = false
        
        return storePromotionDescription
    }()
    
    private lazy var storeDetailsStackView: UIStackView = {
        let storeDetailsStackView = UIStackView()
        storeDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        storeDetailsStackView.axis = .vertical
        storeDetailsStackView.spacing = 8
        
        return storeDetailsStackView
    }()
    
    private lazy var favoriteImageView: UIImageView = {
        let favoriteImageView = UIImageView()
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.image = UIImage(systemName: "heart")
        return favoriteImageView
    }()
    
    private lazy var storeDistance: UILabel = {
        let storeDistance = UILabel()
        storeDistance.translatesAutoresizingMaskIntoConstraints = false
        
        return storeDistance
    }()
    
    private lazy var storeOpen: UILabel = {
        let storeOpen = UILabel()
        storeOpen.translatesAutoresizingMaskIntoConstraints = false
        
        return storeOpen
    }()
    
    func configure(image: URL?, title: String, date: String, participants: String) {
            configureSubviews()
            configureConstraints()
            
        }
    
    func configureSubviews() {
        contentView.layer.cornerRadius = 16
        contentView.addSubview(storeImageView)
        contentView.addSubview(horizontalStackView)
        contentView.addSubview(storeNameDescriptionStackView)
        contentView.addSubview(storeDetailsStackView)
        horizontalStackView.addArrangedSubview(storeNameDescriptionStackView)
        horizontalStackView.addArrangedSubview(storeDetailsStackView)
        storeNameDescriptionStackView.addArrangedSubview(storeName)
        storeNameDescriptionStackView.addArrangedSubview(storePromotionDescription)
        storeDetailsStackView.addArrangedSubview(favoriteImageView)
        storeDetailsStackView.addArrangedSubview(storeDistance)
        storeDetailsStackView.addArrangedSubview(storeOpen)
    }
    
    func configureConstraints() {
        let storeImageConstraints = [
            storeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            storeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            storeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            
        ]
        
        let horizontalContraints = [
            horizontalStackView.trailingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 16)
        ]
        
//        let storeNameDescriptionStackViewConstraints = [
//            storeNameDescriptionStackView.spacing = 8,
//
//        ]
        
    }
    
}

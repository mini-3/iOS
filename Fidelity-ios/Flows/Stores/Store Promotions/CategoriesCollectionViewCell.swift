//
//  CategoriesCollectionViewCell.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 14/10/21.
//

import Foundation
import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
   
    static let identifier: String = String(describing: self)
    
    private lazy var categoryCollectionStackView: UIStackView = {
        let categoryCollectionStackView = UIStackView()
        categoryCollectionStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionStackView.axis = .vertical
        categoryCollectionStackView.spacing = 8
        
        return categoryCollectionStackView
    }()
    
    private lazy var categoryImageView: UIImageView = {
        let categoryImageView = UIImageView()
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        return categoryImageView
    }()
    
    private lazy var categoryName: UILabel = {
        let categoryName = UILabel()
        categoryName.translatesAutoresizingMaskIntoConstraints = false
        
        return categoryName
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryImageView.circleImage()
    }
    
    func configure() {
        configureSubviews()
        configureConstraints()
    }
    
    func configureSubviews() {
        contentView.layer.cornerRadius = 16
        contentView.addSubview(categoryCollectionStackView)
        categoryCollectionStackView.addArrangedSubview(categoryImageView)
        categoryCollectionStackView.addArrangedSubview(categoryName)
    }
    
    func configureConstraints() {
//        let storeImageConstraints = [
//            storeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
//            storeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
//            storeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
//            
//        ]
//        
//        let horizontalContraints = [
//            horizontalStackView.trailingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 16)
//        ]
        
        
    }
}

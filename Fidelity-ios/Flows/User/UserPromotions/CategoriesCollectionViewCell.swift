//
//  CategoriesCollectionViewCell.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 14/10/21.
//

import Foundation
import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    private lazy var categoryCollectionViewCell: UICollectionViewCell = {
        let categoryCollectionViewCell = UICollectionViewCell()
        categoryCollectionViewCell.translatesAutoresizingMaskIntoConstraints = false
        
        return categoryCollectionViewCell
    }()
    
    private lazy var categoryCollectionStackView: UIStackView = {
        let categoryCollectionStackView = UIStackView()
        categoryCollectionStackView.translatesAutoresizingMaskIntoConstraints = false
        
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
}

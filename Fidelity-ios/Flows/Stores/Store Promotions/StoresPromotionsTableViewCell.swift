//
//  StoresTableViewCell.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 14/10/21.
//

import Foundation
import UIKit
import Kingfisher

class StoresPromotionsTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: self)
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "StoreCell")

        return view
    }()
    
    private lazy var storeImageView: UIImageView = {
        let storeImageView = UIImageView()
        storeImageView.translatesAutoresizingMaskIntoConstraints = false
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
        storeNameDescriptionStackView.spacing = 4
        
        return storeNameDescriptionStackView
    }()
    
    private lazy var storeName: UILabel = {
        let storeName = UILabel()
        storeName.translatesAutoresizingMaskIntoConstraints = false
        storeName.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 0.5))
        
        return storeName
    }()
    
    private lazy var storePromotionDescription: UILabel = {
        let storePromotionDescription = UILabel()
        storePromotionDescription.translatesAutoresizingMaskIntoConstraints = false
        storePromotionDescription.numberOfLines = 0
        storePromotionDescription.font = UIFont.systemFont(ofSize: 12)
        
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
    
//    func configure(storeImage: String, storeName: String, storePromotionDescription: String, storeDistance: String, storeOpen: String) {
//        configureSubviews()
//        configureConstraints()
//
//        self.storeImageView.image = UIImage(systemName: "heart")
//        self.storeName.text = storeName
//        self.storePromotionDescription.text = storePromotionDescription
//        self.storeDistance.text = storeDistance
//
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.forEach { $0.removeFromSuperview() }
        self.contentView.constraints.forEach { self.contentView.removeConstraint($0) }
    }
    
    func configure(storeImage: String, storeName: String, storePromotionDescription: String) {
        configureSubviews()
        configureConstraints()
        
        if storeImage == "photo.circle" {
            self.storeImageView.image = UIImage(systemName: storeImage)
        } else {
            let url = URL(string: storeImage)
            self.storeImageView.kf.setImage(with: url)
        }
        storeImageView.layoutIfNeeded()
        storeImageView.circleImage()
        self.storeName.text = storeName
        self.storePromotionDescription.text = storePromotionDescription
        self.contentView.backgroundColor = UIColor(named: "Background")
        
    }
    
    func configureSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(storeImageView)
        //contentView.addSubview(horizontalStackView)
        mainView.addSubview(storeNameDescriptionStackView)
        //contentView.addSubview(storeDetailsStackView)
        //horizontalStackView.addArrangedSubview(storeNameDescriptionStackView)
        //horizontalStackView.addArrangedSubview(storeDetailsStackView)
        storeNameDescriptionStackView.addArrangedSubview(storeName)
        storeNameDescriptionStackView.addArrangedSubview(storePromotionDescription)
        //        storeDetailsStackView.addArrangedSubview(favoriteImageView)
        //        storeDetailsStackView.addArrangedSubview(storeDistance)
        //        storeDetailsStackView.addArrangedSubview(storeOpen)
    }
    
    func configureConstraints() {
        
        let spacing = [
            //mainView.heightAnchor.constraint(equalToConstant: 80),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
            
        ]
        
        let storeImageConstraints = [
            storeImageView.widthAnchor.constraint(equalToConstant: 60),
            storeImageView.heightAnchor.constraint(equalToConstant: 60),
            storeImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            storeImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            storeImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16)
            
        ]
        
//        let horizontalContraints = [
//            horizontalStackView.trailingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: -16)
//        ]
        
        
        let storeNameDescriptionStackViewConstraints = [
            storeNameDescriptionStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            storeNameDescriptionStackView.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 16),
            storeNameDescriptionStackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
            
        ]
        
        //        let storeDetailsStackViewConstraints = [
        //            storeDetailsStackView.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
        //            storeDetailsStackView.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor),
        //            storeDetailsStackView.topAnchor.constraint(equalTo: horizontalStackView.topAnchor)
        //        ]
        
        NSLayoutConstraint.activate(spacing)
        NSLayoutConstraint.activate(storeImageConstraints)
        //NSLayoutConstraint.activate(horizontalContraints)
        NSLayoutConstraint.activate(storeNameDescriptionStackViewConstraints)
        //NSLayoutConstraint.activate(storeDetailsStackViewConstraints)
    }
    
}

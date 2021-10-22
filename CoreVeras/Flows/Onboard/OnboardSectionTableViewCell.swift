//
//  OnboardSectionTableViewCell.swift
//  CoreVeras
//
//  Created by Artur Luis on 21/10/21.
//

import Foundation
import UIKit

class OnboardSectionTableViewCell: UITableViewCell {
    static let identifier = String(describing: self)
    
    private let containerView: UIView = UIView()
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 21,weight: UIFont.Weight(rawValue: 0.5))
        
        label.textColor = .label
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight(rawValue: 0.1))
        label.layer.opacity = 0.5
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    func configure(image: String, title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.iconImage.image = UIImage(named: image)
        self.contentView.backgroundColor = UIColor(named: "Background")
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        //        contentView.addSubview(containerView)
        contentView.addSubview(iconImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func addConstraints() {
        let iconConstraints = [
            iconImage.heightAnchor.constraint(equalToConstant: 60),
            iconImage.widthAnchor.constraint(equalToConstant: 60),
            iconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
        ]
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ]
        let descriptionConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(iconConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(descriptionConstraints)
    }
    
}

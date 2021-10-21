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
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(image: String, title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.iconImage.image = UIImage(named: image)
        addSubviews()
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
    }
    
    private func addConstraints() {
        let containerConstraints = [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ]
        let iconConstraints = [
            iconImage.heightAnchor.constraint(equalToConstant: 35),
            iconImage.widthAnchor.constraint(equalToConstant: 35),
            iconImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            iconImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImage.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -16)
        ]
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 16)
        ]
        let descriptionConstraints = [
            descriptionLabel.leftAnchor.constraint(equalTo: iconImage.leftAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(containerConstraints)
        NSLayoutConstraint.activate(iconConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(descriptionConstraints)
    }
    
}

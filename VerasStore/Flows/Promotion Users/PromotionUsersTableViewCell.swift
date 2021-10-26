//
//  PromotionUsersTableViewCell.swift
//  VerasStore
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/10/21.
//

import UIKit

class PromotionUsersTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: self)
    
    // MARK: - Subviews
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.tintColor = .white
        return label
    }()
    
    // MARK: - Functionalities
    func configure(email: String) {
        emailLabel.text = email
        self.addSubviews()
        self.addConstraints()
        contentView.backgroundColor = UIColor(named: "Background")
    }
    
    private func addSubviews() {
        contentView.addSubview(emailLabel)
    }
    
    private func addConstraints() {
        let emailLabelConstraints = [
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(emailLabelConstraints)
    }
    
}

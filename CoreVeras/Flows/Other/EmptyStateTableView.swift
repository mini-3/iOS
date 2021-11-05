//
//  EmptyStateTableView.swift
//  Fidelity-ios
//
//  Created by Santiago del Castillo Gonzaga on 04/11/21.
//

import UIKit

public class EmptyStateTableView: UIView {
    
    init(image: UIImage, label: String) {
        super.init(frame: .zero)
        self.imageView.image = image
        self.titleLabel.text = label
        
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        imageView.alpha = 0.4
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.alpha = 0.4
        
        return label
    }()
    
    private func addSubviews() {
    
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    private func addConstraints() {

        
        let imageViewConstraints = [
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ]
        
        let titleLabelConstraint = [
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraint)
    }
}

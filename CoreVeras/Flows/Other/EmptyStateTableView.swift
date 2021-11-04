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
    
    private var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .white
        
        return label
    }()
    
    private func addSubviews() {
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(titleLabel)
    }
    
    private func addConstraints() {
        
        let verticalStackViewConstraints = [
            verticalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        let imageViewConstraints = [
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ]
        
        NSLayoutConstraint.activate(verticalStackViewConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
    }
}

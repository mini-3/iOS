//
//  StorePromotionsTableViewCell.swift
//  VerasStore
//
//  Created by Santiago del Castillo Gonzaga on 25/10/21.
//

import UIKit

class StorePromotionsTableViewCell: UITableViewCell {
    static let identifier = String(describing: self)
    
    //MARK: - Subviews
    private var mainView: GradientView = {
        let view = GradientView()
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.random
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }()
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "person.fill")
        
        return imageView
    }()
    
    private var promotionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.textColor = .white
        
        return label
    }()
    
    private var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textColor = .white
        
        return label
    }()
    
    private var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    private var customersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .white
        
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .white
        
        return label
    }()
    
    private var qrCodeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 1
        
        return view
    }()
    
    private var qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "qrcode")
        imageView.backgroundColor = .white
        imageView.tintColor = .black
        imageView.contentScaleFactor = 1
        imageView.alpha = 1
        
        return imageView
    }()

    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Funcionalities
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configure() {
        
    }
    
    private func configureSubViews() {
        mainView.addSubview(horizontalStackView)
        mainView.addSubview(verticalStackView)
        qrCodeView.addSubview(qrCodeImageView)
        mainView.addSubview(qrCodeView)
    }
    
    private func configureStacks() {
        horizontalStackView.addArrangedSubview(avatarImageView)
        horizontalStackView.addArrangedSubview(promotionNameLabel)
        horizontalStackView.addArrangedSubview(amountLabel)
        verticalStackView.addArrangedSubview(customersLabel)
        verticalStackView.addArrangedSubview(dateLabel)
    }
    
    private func configureConstraints() {
        let horizontalStackViewConstraints = [
            horizontalStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            horizontalStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            horizontalStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16)
        ]
        
        let verticalStackViewConstraints = [
            verticalStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: qrCodeView.leadingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 16),
            verticalStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16)
        ]
        
        let qrCodeViewConstraints = [
            qrCodeView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            qrCodeView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(horizontalStackViewConstraints)
        NSLayoutConstraint.activate(verticalStackViewConstraints)
        NSLayoutConstraint.activate(qrCodeViewConstraints)
    }

}

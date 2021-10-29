//
//  StorePromotionsTableViewCell.swift
//  VerasStore
//
//  Created by Santiago del Castillo Gonzaga on 25/10/21.
//

import UIKit
import Kingfisher

protocol StorePromotionsTableViewCellDelegate: AnyObject {
    func didTapQrCodeButton(cell: UITableViewCell)
}

class StorePromotionsTableViewCell: UITableViewCell {
    static let identifier = String(describing: self)
    var delegate: StorePromotionsTableViewCellDelegate?
    
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
        stackView.contentMode = .top
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private var awardNameLabel: UILabel = {
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
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    private var promotionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .white
        
        return label
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
        view.clipsToBounds = true
        
        return view
    }()
    
    private var qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "qrcode")
        imageView.backgroundColor = .white
        imageView.tintColor = .black
        imageView.contentScaleFactor = 1
        
        return imageView
    }()

    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Funcionalities
    
    func configure(promotionName: String, avatar: String, promotionAward: String, amount: Int, customersNumber: Int, dateEnd: String) {
        self.configureSubViews()
        self.configureStacks()
        self.configureConstraints()
        
        contentView.backgroundColor = UIColor(named: "Background")
        self.qrCodeView.layer.cornerRadius = 25
        
        let button = UITapGestureRecognizer(target: self, action: #selector(StorePromotionsTableViewCell.generateTicket))
        qrCodeView.addGestureRecognizer(button)
        
        self.awardNameLabel.text = promotionAward
        self.promotionNameLabel.text = promotionName
        self.amountLabel.text = "\(amount)x"
        self.customersLabel.text = customersNumber == 1 ? "\(customersNumber) participante" : "\(customersNumber) participantes"
        self.dateLabel.text = "Válido \(dateEnd)"
        
        if avatar == "photo.circle" {
            self.avatarImageView.image = UIImage(systemName: avatar)
        } else {
            let url = URL(string: avatar)
            self.avatarImageView.kf.setImage(with: url)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
        
        self.avatarImageView.circleImage()
        
    }
    
    private func configureSubViews() {
        contentView.addSubview(mainView)
        mainView.addSubview(horizontalStackView)
        mainView.addSubview(verticalStackView)
        qrCodeView.addSubview(qrCodeImageView)
        mainView.addSubview(qrCodeView)
    }
    
    private func configureStacks() {
        horizontalStackView.addArrangedSubview(avatarImageView)
        horizontalStackView.addArrangedSubview(awardNameLabel)
        horizontalStackView.addArrangedSubview(amountLabel)
        verticalStackView.addArrangedSubview(promotionNameLabel)
        verticalStackView.addArrangedSubview(customersLabel)
        verticalStackView.addArrangedSubview(dateLabel)
    }
    
    private func configureConstraints() {
        let mainViewConstraints = [
            mainView.heightAnchor.constraint(equalToConstant: 168),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ]
        
        let horizontalStackViewConstraints = [
            horizontalStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            horizontalStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            horizontalStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16)
        ]
        
        let avatarImageViewConstraints = [
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        let verticalStackViewConstraints = [
            verticalStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: qrCodeView.leadingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 16),
            verticalStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -24)
        ]
        
        let qrCodeViewConstraints = [
            qrCodeView.heightAnchor.constraint(equalToConstant: 50),
            qrCodeView.widthAnchor.constraint(equalToConstant: 50),
            qrCodeView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            qrCodeView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -24)
        ]
        
        let qrCodeImageViewConstraints = [
            qrCodeImageView.centerYAnchor.constraint(equalTo: qrCodeView.centerYAnchor),
            qrCodeImageView.centerXAnchor.constraint(equalTo: qrCodeView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(mainViewConstraints)
        NSLayoutConstraint.activate(horizontalStackViewConstraints)
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(verticalStackViewConstraints)
        NSLayoutConstraint.activate(qrCodeViewConstraints)
        NSLayoutConstraint.activate(qrCodeImageViewConstraints)
    }
    
    @objc public func generateTicket() {
        delegate?.didTapQrCodeButton(cell: self)
    }
}

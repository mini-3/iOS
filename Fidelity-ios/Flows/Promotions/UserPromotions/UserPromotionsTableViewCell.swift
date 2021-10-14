//
//  UserPromotionsTableViewCell.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 14/10/21.
//

import UIKit

class UserPromotionsTableViewCell: UITableViewCell {
    static let identifier = String(describing: self)
    
    //MARK: - Subviews
    private let mainView: GradientView = {
        let view = GradientView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.random
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 3
        label.textColor = .white
        return label
    }()
    
    private let ticketCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.textColor = .white
        return label
    }()
    
    private let awardPrizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .black
        return collection
    }()
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Functionalities
    private func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(avatarImageView)
        mainView.addSubview(storeNameLabel)
        mainView.addSubview(ticketCountLabel)
        mainView.addSubview(awardPrizeLabel)
        mainView.addSubview(collectionView)
    }
    
    private func addConstraints() {
        let mainViewConstraints = [
            mainView.heightAnchor.constraint(equalToConstant: 168),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ]
        
        let avatarImageConstraints = [
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            avatarImageView.trailingAnchor.constraint(equalTo: storeNameLabel.leadingAnchor, constant: -16),
            avatarImageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -16)
        ]
        
        let storeNameConstraints = [
            storeNameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            storeNameLabel.trailingAnchor.constraint(equalTo: ticketCountLabel.leadingAnchor, constant: -48),
            storeNameLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -32)
        ]
        
        let ticketCountConstraints = [
            ticketCountLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            ticketCountLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            ticketCountLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -32)
        ]
        
        let awardPrizeConstraints = [
            awardPrizeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            awardPrizeLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            awardPrizeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            awardPrizeLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16)
        ]
        
        let collectionViewContraints = [
            collectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(mainViewConstraints)
        NSLayoutConstraint.activate(avatarImageConstraints)
        NSLayoutConstraint.activate(storeNameConstraints)
        NSLayoutConstraint.activate(ticketCountConstraints)
        NSLayoutConstraint.activate(awardPrizeConstraints)
        NSLayoutConstraint.activate(collectionViewContraints)
    }
    
    func configure(storeName: String, ticketCount: String, awardPrize: String) {
        self.addSubviews()
        self.addConstraints()
        storeNameLabel.text = storeName
        ticketCountLabel.text = ticketCount
        awardPrizeLabel.text = awardPrize
    }

}

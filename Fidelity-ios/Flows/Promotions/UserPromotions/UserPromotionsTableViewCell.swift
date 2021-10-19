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
        view.layer.cornerRadius = 12
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
    
<<<<<<< HEAD
=======
    private let dateEndLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
    private let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = CGSize(width: 32, height: 32)
        }
        collection.register(UserPromotionsCollectionViewCell.self, forCellWithReuseIdentifier: UserPromotionsCollectionViewCell.identifier)
        return collection
    }()
    
    var awardAmount: Int = 0
    var currentAmount: Int = 0
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        awardAmount = 0
        collectionView.reloadData()
    }
    
    //MARK: - Functionalities
    private func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(avatarImageView)
        mainView.addSubview(storeNameLabel)
        mainView.addSubview(ticketCountLabel)
        mainView.addSubview(awardPrizeLabel)
        mainView.addSubview(collectionView)
<<<<<<< HEAD
=======
        mainView.addSubview(dateEndLabel)
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
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
<<<<<<< HEAD
            awardPrizeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            awardPrizeLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0)
        ]
        
=======
            awardPrizeLabel.trailingAnchor.constraint(equalTo: dateEndLabel.leadingAnchor, constant: -16),
            awardPrizeLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0)
        ]
        
        let dateLabelConstraints = [
            dateEndLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            dateEndLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            dateEndLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0)
        ]
        
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
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
<<<<<<< HEAD
    }
    
    func configure(storeName: String, ticketCount: String, awardPrize: String, awardAmount: Int, currentAmount: Int) {
=======
        NSLayoutConstraint.activate(dateLabelConstraints)
    }
    
    func configure(storeName: String, ticketCount: String, awardPrize: String, awardAmount: Int, currentAmount: Int, dateEnd: String) {
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        self.addSubviews()
        self.addConstraints()
        storeNameLabel.text = storeName
        ticketCountLabel.text = ticketCount
        awardPrizeLabel.text = awardPrize
<<<<<<< HEAD
=======
        dateEndLabel.text = dateEnd
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        self.awardAmount = awardAmount
        self.currentAmount = currentAmount
        self.collectionView.dataSource = self
        contentView.backgroundColor = UIColor(named: "Background")
    }

}

extension UserPromotionsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return awardAmount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserPromotionsCollectionViewCell.identifier, for: indexPath) as? UserPromotionsCollectionViewCell else {
            return UICollectionViewCell()
        }
        var hasWon = false
        if indexPath.row < self.currentAmount {
            hasWon = true
        }
        cell.configure(hasWon: hasWon)
        return cell
    }
}

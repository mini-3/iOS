//
//  UserPromotionsTableViewCell.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 14/10/21.
//

import UIKit

protocol UserPromotionsTableViewCellDelegate: AnyObject {
    func didTapCell(code: String)
}

class UserPromotionsTableViewCell: UITableViewCell {
    static let identifier = String(describing: self)
    
    private var code: String?
    private var awardAmount: Int = 0
    private var currentAmount: Int = 0
    weak var delegate: UserPromotionsTableViewCellDelegate?
    
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
        label.setContentHuggingPriority(.required, for: .horizontal)
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
    
    private let dateEndLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
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
    
    private let wonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let wonBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.5
        view.backgroundColor = .white
        return view
    }()
    
    private let qrCodeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 1
        return view
    }()
    
    private let qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "qrcode")
        imageView.backgroundColor = .white
        imageView.tintColor = .black
        imageView.contentScaleFactor = 1
        imageView.alpha = 1
        return imageView
    }()
    
    private let rewardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.axis = .vertical
        stackView.spacing = -20
        return stackView
    }()
    
    private let rewardLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.text = "Fidelidade alcançada!"
        return label
    }()
    
    private let rewardLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.text = "Resgate o seu QR Code"
        return label
    }()
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        awardAmount = 0
        currentAmount = 0
        collectionView.reloadData()
    }
    
    //MARK: - Functionalities
    private func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(avatarImageView)
        mainView.addSubview(storeNameLabel)
        mainView.addSubview(ticketCountLabel)
        mainView.addSubview(awardPrizeLabel)
        qrCodeView.addSubview(qrCodeImageView)
        wonView.addSubview(wonBackgroundView)
        wonView.addSubview(qrCodeView)
        rewardStackView.addArrangedSubview(rewardLabel)
        rewardStackView.addArrangedSubview(rewardLabel2)
        wonView.addSubview(rewardStackView)
        mainView.addSubview(wonView)
        mainView.addSubview(collectionView)
        mainView.addSubview(dateEndLabel)
    }
    
    private func addConstraints() {
        let mainViewConstraints = [
            mainView.heightAnchor.constraint(equalToConstant: 168),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ]
        
        let wonViewConstraints = [
            wonView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            wonView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16)
        ]
        
        let wonBackgroundViewConstraints = [
            wonBackgroundView.leadingAnchor.constraint(equalTo: wonView.leadingAnchor, constant: 0),
            wonBackgroundView.trailingAnchor.constraint(equalTo: wonView.trailingAnchor, constant: 0),
            wonBackgroundView.topAnchor.constraint(equalTo: wonView.topAnchor, constant: 0),
            wonBackgroundView.bottomAnchor.constraint(equalTo: wonView.bottomAnchor, constant: 0)
        ]
        
        let qrCodeViewConstraints = [
            qrCodeView.heightAnchor.constraint(equalToConstant: 40),
            qrCodeView.widthAnchor.constraint(equalToConstant: 40),
            qrCodeView.centerYAnchor.constraint(equalTo: wonView.centerYAnchor),
            qrCodeView.trailingAnchor.constraint(equalTo: wonView.trailingAnchor, constant: -6)
        ]
        
        let qrCodeImageViewConstraints = [
            qrCodeImageView.centerYAnchor.constraint(equalTo: qrCodeView.centerYAnchor),
            qrCodeImageView.centerXAnchor.constraint(equalTo: qrCodeView.centerXAnchor)
        ]
        
        let rewardStackViewConstraints = [
            rewardStackView.leadingAnchor.constraint(equalTo: wonView.leadingAnchor, constant: 16),
            rewardStackView.topAnchor.constraint(equalTo: wonView.topAnchor, constant: 10),
            rewardStackView.heightAnchor.constraint(equalTo: wonView.heightAnchor)
        ]
        
        let avatarImageConstraints = [
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            avatarImageView.trailingAnchor.constraint(equalTo: storeNameLabel.leadingAnchor, constant: -16),
            avatarImageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -16),
            avatarImageView.bottomAnchor.constraint(equalTo: wonView.topAnchor, constant: -4)
        ]
        
        let storeNameConstraints = [
            storeNameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            storeNameLabel.trailingAnchor.constraint(equalTo: ticketCountLabel.leadingAnchor, constant: -48),
            storeNameLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -32),
            storeNameLabel.bottomAnchor.constraint(equalTo: wonView.topAnchor, constant: -20)
        ]
        
        let ticketCountConstraints = [
            ticketCountLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            ticketCountLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            ticketCountLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -32),
            ticketCountLabel.bottomAnchor.constraint(equalTo: wonView.topAnchor, constant: -20)
        ]
        
        let awardPrizeConstraints = [
            awardPrizeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            awardPrizeLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            awardPrizeLabel.trailingAnchor.constraint(equalTo: dateEndLabel.leadingAnchor, constant: -16),
            awardPrizeLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0),
            awardPrizeLabel.topAnchor.constraint(equalTo: wonView.bottomAnchor, constant: 10)
        ]
        
        let dateLabelConstraints = [
            dateEndLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            dateEndLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            dateEndLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0),
            dateEndLabel.topAnchor.constraint(equalTo: wonView.bottomAnchor, constant: 10)
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
        NSLayoutConstraint.activate(dateLabelConstraints)
        NSLayoutConstraint.activate(wonViewConstraints)
        NSLayoutConstraint.activate(qrCodeViewConstraints)
        NSLayoutConstraint.activate(qrCodeImageViewConstraints)
        NSLayoutConstraint.activate(rewardStackViewConstraints)
        NSLayoutConstraint.activate(wonBackgroundViewConstraints)
    }
    
    func configure(storeName: String, ticketCount: String, awardPrize: String, awardAmount: Int, currentAmount: Int, dateEnd: String, code: String) {
        self.addSubviews()
        self.addConstraints()
        self.wonView.layer.cornerRadius = self.wonView.frame.height/2
        self.qrCodeView.layer.cornerRadius = self.qrCodeView.frame.height/2
        self.wonBackgroundView.layer.cornerRadius = self.wonBackgroundView.frame.height/2
        storeNameLabel.text = storeName
        ticketCountLabel.text = ticketCount
        awardPrizeLabel.text = awardPrize
        dateEndLabel.text = dateEnd
        self.awardAmount = awardAmount
        self.currentAmount = currentAmount
        self.collectionView.dataSource = self
        contentView.backgroundColor = UIColor(named: "Background")
        self.code = code
        if awardAmount <= currentAmount && currentAmount > 0 && awardAmount > 0 {
            collectionView.isHidden = true
            wonView.isHidden = false
        } else {
            collectionView.isHidden = false
            wonView.isHidden = true
        }
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

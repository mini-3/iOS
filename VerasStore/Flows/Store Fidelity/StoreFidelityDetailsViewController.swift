//
//  StoreDetailsPresenter.swift
//  VerasStore
//
//  Created by Matheus Homrich on 25/10/21.
//

import Foundation
import UIKit
import Kingfisher

class StoreFidelityDetailsViewController: UIViewController {
    
    //MARK: - scrollView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - CARD VIEW
    private let card: GradientView = {
        let view = GradientView()
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.random
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - CARD INNER VIEWS
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        
        return imageView
    }()
    
    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 3
        label.textColor = .white
        label.text = "storeNameLabel"
        
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
        label.text = "ticketCountLabel"
        
        return label
    }()
    
    private let awardPrizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.text = "awardPrizeLabel"
        
        return label
    }()
    
    //MARK: - DESCRIPTION STACKVIEW
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "secondaryLabel")
        label.numberOfLines = 1
        label.text = "Descrição"
        
        return label
    }()
    
    private lazy var descriptionContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    //MARK: - QUANTITY STACKVIEW
    private lazy var quantityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "secondaryLabel")
        label.numberOfLines = 1
        label.text = "Quantidade"
        
        return label
    }()
    
    private lazy var quantityContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "10" //TODO "Recompensa da promoção"
        
        return label
    }()
    
    //MARK: - AWARD STACKVIEW
    private lazy var awardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var awardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "secondaryLabel")
        label.numberOfLines = 1
        label.text = "Recompensa"
        
        return label
    }()
    
    private lazy var awardContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var horizontalDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    //MARK: - STARTDATE STACKVIEW
    private lazy var startDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "secondaryLabel")
        label.numberOfLines = 1
        label.text = "Data inicial"
        
        return label
    }()
    
    private lazy var startDateContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    //MARK: - ENDDATE STACKVIEW
    private lazy var endDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "secondaryLabel")
        label.numberOfLines = 1
        label.text = "Data final"
        
        return label
    }()
    
    private lazy var endDateContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    //MARK: - PARTICIPANTS STACKVIEW
    private lazy var participantsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var participantsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "secondaryLabel")
        label.numberOfLines = 1
        label.text = "Participantes"
        
        return label
    }()
    
    private lazy var participantsContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    //MARK: - SEEPARTICIPANTS BUTTON
    private lazy var seeParticipantsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ver participantes", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = UIColor(named: "DeleteButtonColor")
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(seeParticipants), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - HORIZONTAL BUTTON STACKVIEW
    private lazy var horizontalButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Editar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = UIColor(named: "DeleteButtonColor")
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(editPromotion), for: .touchUpInside)
        
        return button
    }()
    //MARK: - VERTICAL BUTTON STACKVIEW
    private lazy var verticalButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        
        return stackView
    }()
    
    //MARK: - qrCode Button
    private lazy var qrCodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Mostrar QR Code", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = UIColor(named: "DeleteButtonColor")
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(qrCode), for: .touchUpInside)
        
        return button
    }()
    
    private let presenter = PromotionPresenter()
    private let promotionUsersPresenter = PromotionUsersPresenter()
    var promotionId: Int = 0
    var promotion: PromotionViewModel?
    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.presenter.view = self
        self.promotionUsersPresenter.view = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.fetchOne(withLoadingScreen: false, promotionId: promotionId)
        promotionUsersPresenter.fetch(promotionId: promotionId)
    }
    
    func configureView() {
        self.configureUI()
        self.configureData()
        self.configureSubviews()
        self.configureStacks()
        self.configureConstraints()
        self.setConrnerRadius()
    }
    
    func setConrnerRadius() {
        editButton.layer.cornerRadius = 20
        seeParticipantsButton.layer.cornerRadius = 20
        qrCodeButton.layer.cornerRadius = 20
    }
    
    func configureData() {
        self.storeNameLabel.text = promotion?.storeName
        self.ticketCountLabel.text = promotion?.ticketsNeeded
        self.awardContentLabel.text = promotion?.award
        self.quantityContentLabel.text = promotion?.ticketsNeeded
        self.startDateContentLabel.text = promotion?.startDate
        self.endDateContentLabel.text = promotion?.endDateStringStore
        self.awardPrizeLabel.text = promotion?.award
        self.descriptionContentLabel.text = promotion?.storeDescription
        if promotion?.image == "photo.circle" {
            self.avatarImageView.image = UIImage(systemName: "photo.circle")
        } else {
            if let path = promotion?.image {
                let url = URL(string: path)
                self.avatarImageView.kf.setImage(with: url)
            }
        }
        
        viewLayoutMarginsDidChange()
        self.avatarImageView.circleImage()
        
    }
    
    //MARK: - UI
    func configureUI() {
        title = "Fidelidade"
        view.backgroundColor = UIColor(named: "Background")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - SUBVIEWS
    func configureSubviews() {
        //MARK: - scrollView
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //MARK: - card View
        contentView.addSubview(card)
        card.addSubview(avatarImageView)
        card.addSubview(storeNameLabel)
        card.addSubview(ticketCountLabel)
        card.addSubview(awardPrizeLabel)
        
        //MARK: - description stackView
        contentView.addSubview(descriptionStackView)
        
        //MARK: - quantity stackView
        contentView.addSubview(quantityStackView)
        
        //MARK: - award stackView
        contentView.addSubview(awardStackView)
        
        //MARK: - horizontalDateStackView
        contentView.addSubview(horizontalDateStackView)
        
        //MARK: - startDate stackView
        contentView.addSubview(startDateStackView)
        
        //MARK: - endDate stackView
        contentView.addSubview(endDateStackView)
        
        //MARK: - participants stackView
        contentView.addSubview(participantsStackView)
        
        //MARK: - buttonHorizontalStackView
        contentView.addSubview(horizontalButtonStackView)
        
        //MARK: - buttonVerticalStackView
        contentView.addSubview(verticalButtonStackView)
    }
    
    //MARK: - STACKS
    func configureStacks() {
        
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.addArrangedSubview(descriptionContentLabel)
        quantityStackView.addArrangedSubview(quantityLabel)
        quantityStackView.addArrangedSubview(quantityContentLabel)
        awardStackView.addArrangedSubview(awardLabel)
        awardStackView.addArrangedSubview(awardContentLabel)
        horizontalDateStackView.addArrangedSubview(startDateStackView)
        horizontalDateStackView.addArrangedSubview(endDateStackView)
        startDateStackView.addArrangedSubview(startDateLabel)
        startDateStackView.addArrangedSubview(startDateContentLabel)
        endDateStackView.addArrangedSubview(endDateLabel)
        endDateStackView.addArrangedSubview(endDateContentLabel)
        participantsStackView.addArrangedSubview(participantsLabel)
        participantsStackView.addArrangedSubview(participantsContentLabel)
        horizontalButtonStackView.addArrangedSubview(seeParticipantsButton)
        horizontalButtonStackView.addArrangedSubview(editButton)
        verticalButtonStackView.addArrangedSubview(qrCodeButton)
        
    }
    
    //MARK: - CONSTRAINTS
    func configureConstraints() {
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        let contentViewConstraints = [
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ]
        
        let constraint = contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        constraint.priority = UILayoutPriority(250)
        constraint.isActive = true
        
        
        let avatarImageConstraints = [
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            avatarImageView.trailingAnchor.constraint(equalTo: storeNameLabel.leadingAnchor, constant: -16),
        ]
        
        let storeNameConstraints = [
            storeNameLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            storeNameLabel.trailingAnchor.constraint(equalTo: ticketCountLabel.leadingAnchor, constant: -4),
        ]
        
        let ticketCountConstraints = [
            ticketCountLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            ticketCountLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16)
        ]
        
        let awardPrizeConstraints = [
            awardPrizeLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            awardPrizeLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16)
        ]
        
        let cardViewContraints = [
            card.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 16),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            card.heightAnchor.constraint(equalToConstant: 168)
        ]
        
        let descriptionStackViewContraints = [
            descriptionStackView.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 16),
            descriptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            descriptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ]
        
        let quantityStackViewContraints = [
            quantityStackView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 16),
            quantityStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            quantityStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
            
        ]
        
        let awardStackViewContraints = [
            awardStackView.topAnchor.constraint(equalTo: quantityStackView.bottomAnchor, constant: 16),
            awardStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            awardStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ]
        
        let datesStackViewContraints = [
            horizontalDateStackView.topAnchor.constraint(equalTo: awardStackView.bottomAnchor, constant: 16),
            horizontalDateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            horizontalDateStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ]
        
        let participantsStackViewContraints = [
            participantsStackView.topAnchor.constraint(equalTo: horizontalDateStackView.bottomAnchor, constant: 16),
            participantsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            participantsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ]
        
        let horizontalButtonsStackViewContraints = [
            horizontalButtonStackView.topAnchor.constraint(equalTo: participantsStackView.bottomAnchor, constant: 32),
            horizontalButtonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            horizontalButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ]
        
        let buttonsHeightContraints = [
            editButton.heightAnchor.constraint(equalToConstant: 40),
            seeParticipantsButton.heightAnchor.constraint(equalToConstant: 40),
            qrCodeButton.heightAnchor.constraint(equalToConstant: 40)
            
        ]
        
        let verticalButtonsStackViewContraints = [
            verticalButtonStackView.topAnchor.constraint(equalTo: horizontalButtonStackView.bottomAnchor, constant: 32),
            verticalButtonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            verticalButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            verticalButtonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(avatarImageConstraints)
        NSLayoutConstraint.activate(storeNameConstraints)
        NSLayoutConstraint.activate(ticketCountConstraints)
        NSLayoutConstraint.activate(awardPrizeConstraints)
        NSLayoutConstraint.activate(cardViewContraints)
        NSLayoutConstraint.activate(descriptionStackViewContraints)
        NSLayoutConstraint.activate(quantityStackViewContraints)
        NSLayoutConstraint.activate(awardStackViewContraints)
        NSLayoutConstraint.activate(datesStackViewContraints)
        NSLayoutConstraint.activate(participantsStackViewContraints)
        NSLayoutConstraint.activate(buttonsHeightContraints)
        NSLayoutConstraint.activate(horizontalButtonsStackViewContraints)
        NSLayoutConstraint.activate(verticalButtonsStackViewContraints)
        
    }
    
    //MARK: - buttonAction functions
    
    @objc func qrCode() {
        let vc = GenerateTicketViewController()
        vc.promotion = promotion
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func editPromotion() {
        guard let viewModel = promotion, let promotion = viewModel.promotion else { return }
        let vc = CreateUpdatePromotionViewController()
        vc.configure(type: .update, promotion: promotion)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func seeParticipants() {
        guard let viewModel = promotion, let promotion = viewModel.promotion else { return }
        let vc = PromotionUsersViewController()
        vc.promotionId = promotion.id
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StoreFidelityDetailsViewController: PromotionPresenterDelegate {
    func fetchedOne(promotion: PromotionViewModel) {
        self.promotion = promotion
        self.configureView()
    }
}

extension StoreFidelityDetailsViewController: PromotionUsersPresenterDelegate {
    func fetched(tickets: [Ticket]) {
        let emailUsers = tickets.compactMap { ticket in
            return ticket.email_user
        }
        var aux = [EmailUser]()
        let count = emailUsers.reduce(0) { partialResult, current in
            if !aux.contains(current) {
                aux.append(current)
                return 1 + partialResult
            }
            return partialResult + 0
        }
        DispatchQueue.main.async {
            self.participantsContentLabel.text = count == 1 ? "\(count) participante" : "\(count) participantes"
        }
    }
}

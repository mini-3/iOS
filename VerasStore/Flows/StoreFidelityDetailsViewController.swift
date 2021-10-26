//
//  StoreDetailsPresenter.swift
//  VerasStore
//
//  Created by Matheus Homrich on 25/10/21.
//

import Foundation
import UIKit

class StoreFidelityDetailsViewController: ViewController {
    
    var promotion: PromotionViewModel?
    
    //MARK: - CARD VIEW
    private let card: GradientView = {
        let card = GradientView()
        card.layer.cornerRadius = 12
        card.backgroundColor = UIColor.random
        card.clipsToBounds = true
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    //MARK: - CARD INNER VIEWS
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.tintColor = .white
        avatarImageView.image = UIImage(systemName: "person.fill")
        
        return avatarImageView
    }()
    
    private let storeNameLabel: UILabel = {
        let storeNameLabel = UILabel()
        storeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        storeNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        storeNameLabel.numberOfLines = 3
        storeNameLabel.textColor = .white
        storeNameLabel.text = "storeNameLabel"
        
        return storeNameLabel
    }()
    
    private let ticketCountLabel: UILabel = {
        let ticketCountLabel = UILabel()
        ticketCountLabel.translatesAutoresizingMaskIntoConstraints = false
        ticketCountLabel.setContentHuggingPriority(.required, for: .horizontal)
        ticketCountLabel.font = UIFont.systemFont(ofSize: 14)
        ticketCountLabel.setContentHuggingPriority(.required, for: .horizontal)
        ticketCountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        ticketCountLabel.textColor = .white
        ticketCountLabel.text = "ticketCountLabel"
        
        return ticketCountLabel
    }()
    
    private let awardPrizeLabel: UILabel = {
        let awardPrizeLabel = UILabel()
        awardPrizeLabel.translatesAutoresizingMaskIntoConstraints = false
        awardPrizeLabel.font = UIFont.systemFont(ofSize: 14)
        awardPrizeLabel.textColor = .white
        awardPrizeLabel.text = "awardPrizeLabel"
        
        return awardPrizeLabel
    }()
    
    //MARK: - DESCRIPTION STACKVIEW
    private lazy var descriptionStackView: UIStackView = {
        let descriptionStackView = UIStackView()
        descriptionStackView.axis = .vertical
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.spacing = 2
        
        return descriptionStackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor(named: "secondaryLabel")
        descriptionLabel.numberOfLines = 1
        descriptionLabel.text = "Descrição"
        
        return descriptionLabel
    }()
    
    private lazy var descriptionContentLabel: UILabel = {
        let descriptionContentLabel = UILabel()
        descriptionContentLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionContentLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        descriptionContentLabel.textColor = .label
        descriptionContentLabel.numberOfLines = 0
        descriptionContentLabel.text = "recompensa x" //TODO "Recompensa da promoção"
        
        return descriptionContentLabel
    }()
    
    //MARK: - QUANTITY STACKVIEW
    private lazy var quantityStackView: UIStackView = {
        let quantityStackView = UIStackView()
        quantityStackView.axis = .vertical
        quantityStackView.translatesAutoresizingMaskIntoConstraints = false
        quantityStackView.spacing = 2
        
        return quantityStackView
    }()
    
    private lazy var quantityLabel: UILabel = {
        let quantityLabel = UILabel()
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.font = UIFont.systemFont(ofSize: 14)
        quantityLabel.textColor = UIColor(named: "secondaryLabel")
        quantityLabel.numberOfLines = 1
        quantityLabel.text = "Descrição"
        
        return quantityLabel
    }()
    
    private lazy var quantityContentLabel: UILabel = {
        let quantityContentLabel = UILabel()
        quantityContentLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityContentLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        quantityContentLabel.textColor = .label
        quantityContentLabel.numberOfLines = 0
        quantityContentLabel.text = "10" //TODO "Recompensa da promoção"
        
        return quantityContentLabel
    }()
    
    //MARK: - AWARD STACKVIEW
    private lazy var awardStackView: UIStackView = {
        let awardStackView = UIStackView()
        awardStackView.axis = .vertical
        awardStackView.translatesAutoresizingMaskIntoConstraints = false
        awardStackView.spacing = 2
        
        return awardStackView
    }()
    
    private lazy var awardLabel: UILabel = {
        let awardLabel = UILabel()
        awardLabel.translatesAutoresizingMaskIntoConstraints = false
        awardLabel.font = UIFont.systemFont(ofSize: 14)
        awardLabel.textColor = UIColor(named: "secondaryLabel")
        awardLabel.numberOfLines = 1
        awardLabel.text = "Recompensa"
        
        return awardLabel
    }()
    
    private lazy var awardContentLabel: UILabel = {
        let awardContentLabel = UILabel()
        awardContentLabel.translatesAutoresizingMaskIntoConstraints = false
        awardContentLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        awardContentLabel.textColor = .label
        awardContentLabel.numberOfLines = 0
        awardContentLabel.text = "1 biceps" //TODO "Recompensa da promoção"
        
        return awardContentLabel
    }()
    
    private lazy var horizontalDateStackView: UIStackView = {
        let horizontalDateStackView = UIStackView()
        horizontalDateStackView.axis = .horizontal
        horizontalDateStackView.translatesAutoresizingMaskIntoConstraints = false
        //horizontalDateStackView.spacing = 0
        horizontalDateStackView.distribution = .equalSpacing
        
        return horizontalDateStackView
    }()
    
    //MARK: - STARTDATE STACKVIEW
    private lazy var startDateStackView: UIStackView = {
        let startDateStackView = UIStackView()
        startDateStackView.axis = .vertical
        startDateStackView.translatesAutoresizingMaskIntoConstraints = false
        startDateStackView.spacing = 2
        
        return startDateStackView
    }()
    
    private lazy var startDateLabel: UILabel = {
        let startDateLabel = UILabel()
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.font = UIFont.systemFont(ofSize: 14)
        startDateLabel.textColor = UIColor(named: "secondaryLabel")
        startDateLabel.numberOfLines = 1
        startDateLabel.text = "Data inicial"
        
        return startDateLabel
    }()
    
    private lazy var startDateContentLabel: UILabel = {
        let startDateContentLabel = UILabel()
        startDateContentLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateContentLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        startDateContentLabel.textColor = .label
        startDateContentLabel.numberOfLines = 0
        startDateContentLabel.text = "1 biceps" //TODO "Recompensa da promoção"
        
        return startDateContentLabel
    }()
    
    //MARK: - ENDDATE STACKVIEW
    private lazy var endDateStackView: UIStackView = {
        let endDateStackView = UIStackView()
        endDateStackView.axis = .vertical
        endDateStackView.translatesAutoresizingMaskIntoConstraints = false
        endDateStackView.spacing = 2
        
        return endDateStackView
    }()
    
    private lazy var endDateLabel: UILabel = {
        let endDateLabel = UILabel()
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.font = UIFont.systemFont(ofSize: 14)
        endDateLabel.textColor = UIColor(named: "secondaryLabel")
        endDateLabel.numberOfLines = 1
        endDateLabel.text = "Data final"
        
        return endDateLabel
    }()
    
    private lazy var endDateContentLabel: UILabel = {
        let endDateContentLabel = UILabel()
        endDateContentLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateContentLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        endDateContentLabel.textColor = .label
        endDateContentLabel.numberOfLines = 0
        endDateContentLabel.text = "1 biceps" //TODO "Recompensa da promoção"
        
        return endDateContentLabel
    }()
    
    private lazy var horizontalParticipantsStackView: UIStackView = {
        let horizontalParticipantsStackView = UIStackView()
        horizontalParticipantsStackView.axis = .horizontal
        horizontalParticipantsStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalParticipantsStackView.spacing = 16
        
        return horizontalParticipantsStackView
    }()
    
    //MARK: - PARTICIPANTS STACKVIEW
    private lazy var participantsStackView: UIStackView = {
        let participantsStackView = UIStackView()
        participantsStackView.axis = .vertical
        participantsStackView.translatesAutoresizingMaskIntoConstraints = false
        participantsStackView.spacing = 2
        
        return participantsStackView
    }()
    
    private lazy var participantsLabel: UILabel = {
        let participantsLabel = UILabel()
        participantsLabel.translatesAutoresizingMaskIntoConstraints = false
        participantsLabel.font = UIFont.systemFont(ofSize: 14)
        participantsLabel.textColor = UIColor(named: "secondaryLabel")
        participantsLabel.numberOfLines = 1
        participantsLabel.text = "Participantes"
        
        return participantsLabel
    }()
    
    private lazy var participantsContentLabel: UILabel = {
        let participantsContentLabel = UILabel()
        participantsContentLabel.translatesAutoresizingMaskIntoConstraints = false
        participantsContentLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        participantsContentLabel.textColor = .label
        participantsContentLabel.numberOfLines = 0
        participantsContentLabel.text = "150" //TODO "Recompensa da promoção"
        
        return participantsContentLabel
    }()
    
    //MARK: - SEEPARTICIPANTS BUTTON
    private lazy var seeParticipantsButton: UIButton = {
        let seeParticipantsButton = UIButton()
        seeParticipantsButton.translatesAutoresizingMaskIntoConstraints = false
        seeParticipantsButton.setTitle("Ver participantes", for: .normal)
        seeParticipantsButton.setTitleColor(.black, for: .normal)
        seeParticipantsButton.titleLabel?.textColor = UIColor(named: "DeleteButtonColor")
        seeParticipantsButton.backgroundColor = .white
        seeParticipantsButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        seeParticipantsButton.titleLabel?.textAlignment = .center
        //seeParticipantsButton.addTarget(self, action: #selector(seeParticipants), for: .touchUpInside)
        
        return seeParticipantsButton
    }()
    
    //MARK: - HORIZONTAL BUTTON STACKVIEW
    private lazy var horizontalButtonStackView: UIStackView = {
        let horizontalButtonStackView = UIStackView()
        horizontalButtonStackView.axis = .horizontal
        horizontalButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalButtonStackView.spacing = 8
        horizontalButtonStackView.distribution = .fillEqually
        
        return horizontalButtonStackView
    }()
    
    private lazy var editButton: UIButton = {
        let editButton = UIButton()
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setTitle("Editar", for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.titleLabel?.textColor = UIColor(named: "DeleteButtonColor")
        editButton.backgroundColor = .white
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        editButton.titleLabel?.textAlignment = .center
        //seeParticipantsButton.addTarget(self, action: #selector(editPromotion), for: .touchUpInside)
        
        return editButton
    }()
    
    private lazy var endButton: UIButton = {
        let endButton = UIButton()
        endButton.translatesAutoresizingMaskIntoConstraints = false
        endButton.setTitle("Encerrrar", for: .normal)
        endButton.setTitleColor(.black, for: .normal)
        endButton.titleLabel?.textColor = UIColor(named: "DeleteButtonColor")
        endButton.backgroundColor = .white
        endButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        endButton.titleLabel?.textAlignment = .center
        //seeParticipantsButton.addTarget(self, action: #selector(endPromotion), for: .touchUpInside)
        
        return editButton
    }()
    
    //MARK: - VERTICAL BUTTON STACKVIEW
    private lazy var verticalButtonStackView: UIStackView = {
        let verticalButtonStackView = UIStackView()
        verticalButtonStackView.axis = .vertical
        verticalButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalButtonStackView.spacing = 4
        
        return horizontalButtonStackView
    }()
    
    //MARK: - registerClient Button
    private lazy var registerClientButton: UIButton = {
        let registerClientButton = UIButton()
        registerClientButton.translatesAutoresizingMaskIntoConstraints = false
        registerClientButton.setTitle("Cadastrar cliente", for: .normal)
        registerClientButton.setTitleColor(.black, for: .normal)
        registerClientButton.titleLabel?.textColor = UIColor(named: "DeleteButtonColor")
        registerClientButton.backgroundColor = .white
        registerClientButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        registerClientButton.titleLabel?.textAlignment = .center
        //seeParticipantsButton.addTarget(self, action: #selector(endPromotion), for: .touchUpInside)
        
        return registerClientButton
    }()
    
    //MARK: - qrCode Button
    private lazy var qrCodeButton: UIButton = {
        let qrCodeButton = UIButton()
        qrCodeButton.translatesAutoresizingMaskIntoConstraints = false
        qrCodeButton.setTitle("Mostrar QR Code", for: .normal)
        qrCodeButton.setTitleColor(.black, for: .normal)
        qrCodeButton.titleLabel?.textColor = UIColor(named: "DeleteButtonColor")
        qrCodeButton.backgroundColor = .white
        qrCodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        qrCodeButton.titleLabel?.textAlignment = .center
        //seeParticipantsButton.addTarget(self, action: #selector(endPromotion), for: .touchUpInside)
        
        return qrCodeButton
    }()
    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureSubviews()
        self.configureStacks()
        self.configureConstraints()
        self.setConrnerRadius()
        self.configureData()
    }
    
    func setConrnerRadius() {
        editButton.layer.cornerRadius = 20
        seeParticipantsButton.layer.cornerRadius = 20
        registerClientButton.layer.cornerRadius = 20
        qrCodeButton.layer.cornerRadius = 20
        
    }
    
    func configureData() {
        storeNameLabel.text = "teste" //promotion?.storeName
        ticketCountLabel.text = "teste" //promotion?.ticketsNeeded
        awardContentLabel.text = "teste" //promotion?.award
        quantityContentLabel.text = "teste" //promotion?.ticketsNeeded
        participantsContentLabel.text = "teste" //promotion?.usersCount
        startDateContentLabel.text = "teste" //promotion?.startDate
        endDateContentLabel.text = "teste" //promotion?.endDateStringStore
        awardPrizeLabel.text = "teste" //promotion?.award
        descriptionContentLabel.text = "teste" //promotion?.storeDescription
    }
    
    //MARK: - UI
    func configureUI() {
        title = "TESTE"
        view.backgroundColor = UIColor(named: "Background")
    }
    
    //MARK: - SUBVIEWS
    func configureSubviews() {
        //MARK: - card View
        view.addSubview(card)
        card.addSubview(avatarImageView)
        card.addSubview(storeNameLabel)
        card.addSubview(ticketCountLabel)
        card.addSubview(awardPrizeLabel)
        
        //MARK: - description stackView
        view.addSubview(descriptionStackView)
        
        //MARK: - quantity stackView
        view.addSubview(quantityStackView)
        
        //MARK: - award stackView
        view.addSubview(awardStackView)
        
        //MARK: - horizontalDateStackView
        view.addSubview(horizontalDateStackView)
        
        //MARK: - startDate stackView
        view.addSubview(startDateStackView)
        
        //MARK: - endDate stackView
        view.addSubview(endDateStackView)
        
        //MARK: - participantsAndButtonStackView
        //view.addSubview(horizontalParticipantsStackView)
        
        //MARK: - participants stackView
        view.addSubview(participantsStackView)
        
        //MARK: - buttonHorizontalStackView
        view.addSubview(horizontalButtonStackView)
        
        //MARK: - buttonVerticalStackView
        view.addSubview(verticalButtonStackView)
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
        //horizontalParticipantsStackView.addArrangedSubview(participantsStackView)
        //horizontalParticipantsStackView.addArrangedSubview(seeParticipantsButton)
        participantsStackView.addArrangedSubview(participantsLabel)
        participantsStackView.addArrangedSubview(participantsContentLabel)
        horizontalButtonStackView.addArrangedSubview(seeParticipantsButton)
        horizontalButtonStackView.addArrangedSubview(editButton)
        verticalButtonStackView.addArrangedSubview(registerClientButton)
        verticalButtonStackView.addArrangedSubview(qrCodeButton)
        
    }
    
    //MARK: - CONSTRAINTS
    func configureConstraints() {
        
        let avatarImageConstraints = [
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            avatarImageView.trailingAnchor.constraint(equalTo: storeNameLabel.leadingAnchor, constant: -16),
        ]
        
        let storeNameConstraints = [
            storeNameLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            storeNameLabel.trailingAnchor.constraint(equalTo: ticketCountLabel.leadingAnchor, constant: -48),
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
            card.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            card.heightAnchor.constraint(equalToConstant: 168)
            //card.bottomAnchor.constraint(equalTo: descriptionStackView.topAnchor)
        ]
        
        let descriptionStackViewContraints = [
            descriptionStackView.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 16),
            descriptionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            descriptionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            //descriptionStackView.bottomAnchor.constraint(equalTo: quantityStackView.topAnchor)
        ]
        
        let quantityStackViewContraints = [
            quantityStackView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 16),
            quantityStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            quantityStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            //quantityStackView.bottomAnchor.constraint(equalTo: awardStackView.topAnchor)
            
        ]
        
        let awardStackViewContraints = [
            awardStackView.topAnchor.constraint(equalTo: quantityStackView.bottomAnchor, constant: 16),
            awardStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            awardStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ]
        
        let datesStackViewContraints = [
            horizontalDateStackView.topAnchor.constraint(equalTo: awardStackView.bottomAnchor, constant: 16),
            horizontalDateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            horizontalDateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ]
        
        //        let horizontalParticipantsStackViewContraints = [
        //            horizontalParticipantsStackView.topAnchor.constraint(equalTo: horizontalDateStackView.bottomAnchor, constant: 16),
        //            horizontalParticipantsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
        //            horizontalParticipantsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        //        ]
        
        let participantsStackViewContraints = [
            participantsStackView.topAnchor.constraint(equalTo: horizontalDateStackView.bottomAnchor, constant: 16),
            participantsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            participantsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ]
        
        let horizontalButtonsStackViewContraints = [
            horizontalButtonStackView.topAnchor.constraint(equalTo: participantsStackView.bottomAnchor, constant: 16),
            horizontalButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            horizontalButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ]
        
        let buttonsHeightContraints = [
            editButton.heightAnchor.constraint(equalToConstant: 40),
            seeParticipantsButton.heightAnchor.constraint(equalToConstant: 40),
            qrCodeButton.heightAnchor.constraint(equalToConstant: 40),
            registerClientButton.heightAnchor.constraint(equalToConstant: 40)
            
        ]
        
        let verticalButtonsStackViewContraints = [
            verticalButtonStackView.topAnchor.constraint(equalTo: horizontalButtonStackView.bottomAnchor, constant: 16),
            //verticalButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            verticalButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            verticalButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ]
        
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
        //NSLayoutConstraint.activate(horizontalParticipantsStackViewContraints)
        NSLayoutConstraint.activate(horizontalButtonsStackViewContraints)
        NSLayoutConstraint.activate(verticalButtonsStackViewContraints)
        
    }
}

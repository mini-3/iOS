//
//  CreateUpdatePromotionViewController.swift
//  VerasStore
//
//  Created by Pedro Gomes Rubbo Pacheco on 26/10/21.
//

import UIKit
import Kingfisher

enum PromotionManipulationType {
    case create
    case update
}

class CreateUpdatePromotionViewController: UIViewController, PromotionPresenterDelegate {
    
    // MARK: - Subviews
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

    private let cardView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.image = UIImage(named: "photo.circle")
        imageView.clipsToBounds = true
        imageView.circleImage()
        return imageView
    }()
    
    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let awardNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Recompensa: "
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome"
        return label
    }()
    
    private let nameTextField: TextField = {
        let textField = TextField(placeholder: "")
        return textField
    }()
    
    private let ticketTypeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let ticketTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tipo/Requisito"
        return label
    }()
    
    private let ticketTypeTextField: TextField = {
        let textField = TextField(placeholder: "")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let winAmountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let winAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quantidade"
        return label
    }()
    
    private let winAmountTextField: TextField = {
        let textField = TextField(placeholder: "")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let awardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let awardLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recompensa"
        return label
    }()
    
    private let awardTextField: TextField = {
        let textField = TextField(placeholder: "")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let datesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let startDatePicker: DatePicker = {
        let datePicker = DatePicker(label: "Início")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.picker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        return datePicker
    }()
    
    private let endDatePicker: DatePicker = {
        let datePicker = DatePicker(label: "Fim")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let finishButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Encerrar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let executeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 19
        return button
    }()
    
    private var promotion: Promotion?
    private var type: PromotionManipulationType = .create
    private let presenter = PromotionPresenter()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        self.tabBarController?.tabBar.isHidden = false
        self.addSubviews()
        self.addConstraints()
        if let promotion = promotion, let store = promotion.store {
            self.storeImageView.kf.setImage(with: URL(string: store.avatar ?? ""))
        }
        self.storeImageView.layer.cornerRadius = self.storeImageView.frame.height/2
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapExecute))
        executeButton.addGestureRecognizer(gesture)
        
        let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDelete))
        finishButton.addGestureRecognizer(deleteGesture)
        presenter.view = self
        awardTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        self.nameTextField.delegate = self
        self.ticketTypeTextField.delegate = self
        self.winAmountTextField.delegate = self
        self.awardTextField.delegate = self
        self.endDatePicker.picker.minimumDate = startDatePicker.picker.date
    }
    
    func configureTexts(promotion: Promotion) {
        self.nameTextField.text = promotion.name
        self.awardTextField.text = promotion.award
        self.winAmountTextField.text = "\(promotion.win_ticket_amount)"
        self.ticketTypeTextField.text = promotion.ticket_type
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        self.startDatePicker.picker.date = formatter.date(from: promotion.start) ?? Date()
        self.endDatePicker.picker.date = formatter.date(from: promotion.end) ?? Date()
        self.awardNameLabel.text = "Recompensa: \(promotion.award)"
        if let store = promotion.store {
            self.storeNameLabel.text = store.name
        }
    }
    
    func configure(type: PromotionManipulationType, promotion: Promotion?){
        self.promotion = promotion
        switch type {
        case .create:
            self.finishButton.isHidden = true
            title = "Nova Fidelidade"
            let gearButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(gearButtonAction))
            navigationItem.rightBarButtonItem = gearButton
            
            executeButton.setTitle("Criar", for: .normal)
        case .update:
            self.finishButton.isHidden = false
            title = "Editar Fidelidade"
            executeButton.setTitle("Atualizar", for: .normal)
            self.type = .update
        }
        if let promotion = promotion {
            configureTexts(promotion: promotion)
        }
    }
    
    // MARK: - ObjC
    @objc func textFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        awardNameLabel.text = "Recompensa: \(text)"
    }
    
    @objc func didTapDelete() {
        guard let promotion = promotion else {
            return
        }
        self.presenter.delete(promotionId: promotion.id)
    }
    
    @objc func didTapExecute() {
        self.executeButton.pulsate()
        if let winAmount = winAmountTextField.text {
            switch type {
            case .create:
                self.presenter.create(name: nameTextField.text, ticketType: ticketTypeTextField.text, winTicketAmount: Int(winAmount), award: awardTextField.text, start: startDatePicker.picker.date, end: endDatePicker.picker.date, storeId: SessionService.shared.storeId)
            case .update:
                guard let promotion = promotion else { return }
                self.presenter.update(promotionId: promotion.id, name: nameTextField.text, ticketType: ticketTypeTextField.text, winTicketAmount: Int(winAmount), award: awardTextField.text, start: startDatePicker.picker.date, end: endDatePicker.picker.date)
            }
        }
    }
    
    @objc private func gearButtonAction() {
        let configVC = StoreConfigurationViewController()
        configVC.modalPresentationStyle = .automatic
        let navVC = UINavigationController(rootViewController: configVC)
        navVC.modalPresentationStyle = .automatic
        self.present(navVC, animated: true)
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        self.endDatePicker.picker.minimumDate = startDatePicker.picker.date
    }
    
    // MARK: - Functions
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(cardView)
        cardView.addSubview(storeImageView)
        cardView.addSubview(storeNameLabel)
        cardView.addSubview(awardNameLabel)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        contentView.addSubview(nameStackView)
        ticketTypeStackView.addArrangedSubview(ticketTypeLabel)
        ticketTypeStackView.addArrangedSubview(ticketTypeTextField)
        contentView.addSubview(ticketTypeStackView)
        winAmountStackView.addArrangedSubview(winAmountLabel)
        winAmountStackView.addArrangedSubview(winAmountTextField)
        contentView.addSubview(winAmountStackView)
        awardStackView.addArrangedSubview(awardLabel)
        awardStackView.addArrangedSubview(awardTextField)
        contentView.addSubview(awardStackView)
        datesStackView.addArrangedSubview(startDatePicker)
        datesStackView.addArrangedSubview(endDatePicker)
        contentView.addSubview(datesStackView)
        contentView.addSubview(finishButton)
        contentView.addSubview(executeButton)
    }
    
    private func addConstraints() {
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
        
        let cardViewConstraints = [
            cardView.heightAnchor.constraint(equalToConstant: 168),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            cardView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
        ]
        
        let imageViewConstraints = [
            storeImageView.heightAnchor.constraint(equalToConstant: 48),
            storeImageView.widthAnchor.constraint(equalToConstant: 48),
            storeImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            storeImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20)
        ]
        
        let storeNameLabelConstraints = [
            storeNameLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 16),
            storeNameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20)
        ]
        
        let awardNameLabelConstraints = [
            awardNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            awardNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 24),
            awardNameLabel.topAnchor.constraint(equalTo: storeImageView.bottomAnchor, constant: 60)
        ]
        
        let nameStackViewConstraints = [
            nameStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            nameStackView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 8),
            nameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
        ]
        
        let ticketTypeStackViewConstraints = [
            ticketTypeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            ticketTypeStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 8),
            ticketTypeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
        ]
        
        let winAmountStackViewConstraints = [
            winAmountStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            winAmountStackView.topAnchor.constraint(equalTo: ticketTypeStackView.bottomAnchor, constant: 8),
            winAmountStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
        ]
        
        let awardStackViewConstraints = [
            awardStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            awardStackView.topAnchor.constraint(equalTo: winAmountStackView.bottomAnchor, constant: 8),
            awardStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
        ]
        
        let datesStackViewConstraints = [
            datesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            datesStackView.topAnchor.constraint(equalTo: awardStackView.bottomAnchor, constant: 16),
            datesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
        ]
        
        let finishButtonConstraints = [
            finishButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            finishButton.topAnchor.constraint(equalTo: datesStackView.bottomAnchor, constant: 16),
            finishButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            finishButton.heightAnchor.constraint(equalToConstant: 38)
        ]
        
        let executeButtonConstraints = [
            executeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            executeButton.topAnchor.constraint(equalTo: finishButton.bottomAnchor, constant: 16),
            executeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            executeButton.heightAnchor.constraint(equalToConstant: 38),
            executeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ]
        
        let inputHeightConstraints = [
            nameTextField.heightAnchor.constraint(equalToConstant: 38),
            ticketTypeTextField.heightAnchor.constraint(equalToConstant: 38),
            winAmountTextField.heightAnchor.constraint(equalToConstant: 38),
            awardTextField.heightAnchor.constraint(equalToConstant: 38),
            startDatePicker.heightAnchor.constraint(equalToConstant: 40),
            endDatePicker.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(cardViewConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(storeNameLabelConstraints)
        NSLayoutConstraint.activate(awardNameLabelConstraints)
        NSLayoutConstraint.activate(nameStackViewConstraints)
        NSLayoutConstraint.activate(inputHeightConstraints)
        NSLayoutConstraint.activate(ticketTypeStackViewConstraints)
        NSLayoutConstraint.activate(winAmountStackViewConstraints)
        NSLayoutConstraint.activate(awardStackViewConstraints)
        NSLayoutConstraint.activate(datesStackViewConstraints)
        NSLayoutConstraint.activate(finishButtonConstraints)
        NSLayoutConstraint.activate(executeButtonConstraints)
    }
    
}

extension CreateUpdatePromotionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.nameTextField:
            let _ = self.ticketTypeTextField.becomeFirstResponder()
        case self.ticketTypeTextField:
            let _ = self.winAmountTextField.becomeFirstResponder()
        case self.winAmountTextField:
            let _ = self.awardTextField.becomeFirstResponder()
        case self.awardTextField:
            let _ = self.awardTextField.becomeFirstResponder()
        default:
            let _ = self.awardTextField.becomeFirstResponder()
        }
    }
}

//
//  CreateUpdatePromotionViewController.swift
//  VerasStore
//
//  Created by Pedro Gomes Rubbo Pacheco on 26/10/21.
//

import UIKit

enum PromotionManipulationType {
    case create
    case update
}

class CreateUpdatePromotionViewController: UIViewController, PromotionPresenterDelegate {
    
    // MARK: - Subviews
    private let cardView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        self.addSubviews()
        self.addConstraints()
        self.configure(type: .create)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapExecute))
        executeButton.addGestureRecognizer(gesture)
        presenter.view = self
    }
    
    func configure(type: PromotionManipulationType){
        switch type {
        case .create:
            executeButton.setTitle("Criar", for: .normal)
        case .update:
            executeButton.setTitle("Atualizar", for: .normal)
            self.type = .update
        }
    }
    
    // MARK: - ObjC
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
    
    // MARK: - Functions
    private func addSubviews() {
        view.addSubview(cardView)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        view.addSubview(nameStackView)
        ticketTypeStackView.addArrangedSubview(ticketTypeLabel)
        ticketTypeStackView.addArrangedSubview(ticketTypeTextField)
        view.addSubview(ticketTypeStackView)
        winAmountStackView.addArrangedSubview(winAmountLabel)
        winAmountStackView.addArrangedSubview(winAmountTextField)
        view.addSubview(winAmountStackView)
        awardStackView.addArrangedSubview(awardLabel)
        awardStackView.addArrangedSubview(awardTextField)
        view.addSubview(awardStackView)
        datesStackView.addArrangedSubview(startDatePicker)
        datesStackView.addArrangedSubview(endDatePicker)
        view.addSubview(datesStackView)
        view.addSubview(finishButton)
        view.addSubview(executeButton)
    }
    
    private func addConstraints() {
        let cardViewConstraints = [
            cardView.heightAnchor.constraint(equalToConstant: 168),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            cardView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ]
        
        let nameStackViewConstraints = [
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nameStackView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 8),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ]
        
        let ticketTypeStackViewConstraints = [
            ticketTypeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            ticketTypeStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 8),
            ticketTypeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ]
        
        let winAmountStackViewConstraints = [
            winAmountStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            winAmountStackView.topAnchor.constraint(equalTo: ticketTypeStackView.bottomAnchor, constant: 8),
            winAmountStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ]
        
        let awardStackViewConstraints = [
            awardStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            awardStackView.topAnchor.constraint(equalTo: winAmountStackView.bottomAnchor, constant: 8),
            awardStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ]
        
        let datesStackViewConstraints = [
            datesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            datesStackView.topAnchor.constraint(equalTo: awardStackView.bottomAnchor, constant: 16),
            datesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ]
        
        let finishButtonConstraints = [
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            finishButton.topAnchor.constraint(equalTo: datesStackView.bottomAnchor, constant: 16),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            finishButton.heightAnchor.constraint(equalToConstant: 38)
        ]
        
        let executeButtonConstraints = [
            executeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            executeButton.topAnchor.constraint(equalTo: finishButton.bottomAnchor, constant: 16),
            executeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            executeButton.heightAnchor.constraint(equalToConstant: 38)
        ]
        
        let inputHeightConstraints = [
            nameTextField.heightAnchor.constraint(equalToConstant: 38),
            ticketTypeTextField.heightAnchor.constraint(equalToConstant: 38),
            winAmountTextField.heightAnchor.constraint(equalToConstant: 38),
            awardTextField.heightAnchor.constraint(equalToConstant: 38),
            startDatePicker.heightAnchor.constraint(equalToConstant: 40),
            endDatePicker.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(cardViewConstraints)
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

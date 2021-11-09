//
//  DatePicker.swift
//  Fidelity-ios
//
//  Created by Artur Luis on 19/10/21.
//

import UIKit

class DatePicker: UIView {
    
    init(label: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0
        self.label.text = label
        self.backgroundColor = UIColor.init(rgb: 0x4F4F4F)
        
        addSubviews()
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Views
    public let picker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Aniversário"
        label.textColor = .tertiaryLabel
        return label
    }()
    
    // MARK - Methods
    private func addSubviews() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(self.label)
        stackView.addArrangedSubview(picker)
    }
    
    private func addConstraints() {
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        ]
        
        let labelConstraints = [
            label.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(labelConstraints)
    }
}

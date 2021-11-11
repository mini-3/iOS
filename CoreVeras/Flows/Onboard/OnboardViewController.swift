//
//  Onboard.swift
//  CoreVeras
//
//  Created by Artur Luis on 21/10/21.
//

import Foundation
import UIKit

struct OnboardSection {
    var image: String
    var title: String
    var description: String
}

class OnboardViewController: UIViewController {
    
    var sections: [OnboardSection] = []
    var handleContinue: () -> Void = { }
    
    override func viewDidLoad() {
        addSubviews()
        addConstrainst()
        configureTableView()
        view.backgroundColor = UIColor(named: "Background")
        self.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        titleLabel.text = "Bem vindo ao Veras"
    }
    
    //MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36)
        label.textAlignment = .center
        return label
    }()
    
    private let sectionsTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(OnboardSectionTableViewCell.self, forCellReuseIdentifier: OnboardSectionTableViewCell.identifier)
        tableView.backgroundColor = .systemPink
        return tableView
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        return button
    }()
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(sectionsTable)
        view.addSubview(continueButton)
    }
    
    private func addConstrainst() {
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ]
        
        let sectionsTableContrainsts = [
            sectionsTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            sectionsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            sectionsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            sectionsTable.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -32)
        ]
        
        let continueButtonConstraints = [
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(sectionsTableContrainsts)
        NSLayoutConstraint.activate(continueButtonConstraints)
    }
    
    //MARK: - Methods
    private func configureTableView() {
        self.sectionsTable.dataSource = self
        self.sectionsTable.separatorStyle = .none
        self.sectionsTable.backgroundColor = UIColor(named: "Background")
    }
    
    public func configure(title: String, sections: [OnboardSection], handleContinue: @escaping () -> Void) {
        self.titleLabel.text = title
        self.sections = sections
        self.handleContinue = handleContinue
        self.sectionsTable.reloadData()
    }
    
    @objc private func didTapContinue() {
        handleContinue()
    }
    
}

extension OnboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.sectionsTable.dequeueReusableCell(withIdentifier: OnboardSectionTableViewCell.identifier) as? OnboardSectionTableViewCell else { fatalError() }
        let section = sections[indexPath.row]
        cell.configure(image: section.image, title: section.title, description: section.description)
        
        return cell
    }
    
    
}

//
//  StorePromotionsViewController.swift
//  VerasStore
//
//  Created by Santiago del Castillo Gonzaga on 25/10/21.
//

import Foundation
import UIKit

class StorePromotionsViewController: UIViewController {
    
    //MARK: - SubViews
    
    private var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }()
    
    private var storeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "Nome da loja"
        
        return label
    }()
    
    private var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }()
    
    private var customersLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "0 clientes"
        
        return label
    }()
    
    private var customersLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "em fidelidade"
        
        return label
    }()
    
    private var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Ativas", "Desativadas"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.selectedSegmentIndex = 0
        
        return segmented
    }()
    
    private var promotionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "Background")
        tableView.register(StorePromotionsTableViewCell.self, forCellReuseIdentifier: StorePromotionsTableViewCell.identifier)
        
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureSubViews()
        self.configureConstraints()
        self.configureStacks()
    }
    
    //MARK: - Functionalities
    
    private func configureUI() {
        view.backgroundColor = UIColor(named: "Background")
    }
    
    private func configureSubViews() {
        view.addSubview(segmentedControl)
        view.addSubview(promotionsTableView)
    }
    
    private func configureConstraints() {
        let segmentedControlConstraints = [
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedControl.superview!.centerXAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControl.superview!.leadingAnchor, constant: 32),
            segmentedControl.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ]
        
        let promotionsTableViewConstraints = [
            promotionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            promotionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            promotionsTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            promotionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(segmentedControlConstraints)
        NSLayoutConstraint.activate(promotionsTableViewConstraints)
    }
    
    private func configureStacks() {
        
    }
    
    private func configureRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        self.promotionsTableView.refreshControl = refresh
    }
    
    // MARK: - Objc
    
    @objc private func didRefresh() {
        print("teste")
    }
}

//
//  StorePromotionsViewController.swift
//  VerasStore
//
//  Created by Santiago del Castillo Gonzaga on 25/10/21.
//

import Foundation
import UIKit

class StorePromotionsViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Ativas", "Desativadas"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.selectedSegmentIndex = 0
        return segmented
    }()
    
    private let promotionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StorePromotionsTableViewCell.self, forCellReuseIdentifier: StorePromotionsTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureSubViews()
        self.configureConstraints()
    }
    
    private func configureUI() {
        title = "Nome da loja"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "Background")
    }
    
    private func configureSubViews() {
        view.addSubview(segmentedControl)
        view.addSubview(promotionsTableView)
    }
    
    private func configureConstraints() {
        
    }
    
    private func configureRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        self.promotionsTableView.refreshControl = refresh
    }
    
    @objc private func didRefresh() {
        print("teste")
    }
}

//
//  PromotionUsersViewController.swift
//  VerasStore
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/10/21.
//

import UIKit

class PromotionUsersViewController: UIViewController {
    
    // MARK: - Subviews
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PromotionUsersTableViewCell.self, forCellReuseIdentifier: PromotionUsersTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "Background")
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "Buscar"
        return searchController
    }()
    
    private var emptyState: EmptyStateTableView = {
        let empty = EmptyStateTableView(image: UIImage(systemName: "person.fill")!, label: "O estabelecimento ainda não tem clientes cadastrados. Divulgue as promoções e fidelize mais seus clientes!")
        empty.translatesAutoresizingMaskIntoConstraints = false
        
        return empty
    }()
    
    private var tickets: [Ticket] = []
    private var filteredTickets: [Ticket] = []
    private let presenter = PromotionUsersPresenter()
    var promotionId = 1
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        presenter.view = self
        self.configureUI()
        self.addSubviews()
        self.addConstraints()
        self.emptyStateControl()
        presenter.fetch(promotionId: promotionId)
    }
    
    // MARK: - Functionalities
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(emptyState)
    }
    
    private func addConstraints() {
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let emptyStateConstraints = [
            emptyState.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyState.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyState.heightAnchor.constraint(equalToConstant: 300),
            emptyState.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
        NSLayoutConstraint.activate(emptyStateConstraints)
    }
    
    private func configureUI() {
        title = "Clientes"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "Background")
    }
    
    private func emptyStateControl() {
        if filteredTickets.count == 0 {
            emptyState.isHidden = false
            tableView.isHidden = true
        } else {
            emptyState.isHidden = true
            tableView.isHidden = false
        }
    }
}

extension PromotionUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromotionUsersTableViewCell.identifier, for: indexPath) as? PromotionUsersTableViewCell
        else {
            return UITableViewCell()
        }
        let model = filteredTickets[indexPath.row]
        guard let emailUser = model.email_user else { return UITableViewCell() }
        cell.configure(email: emailUser.email)
        return cell
    }
    
}

extension PromotionUsersViewController: PromotionUsersPresenterDelegate {
    func fetched(tickets: [Ticket]) {
        self.tickets = tickets
        self.filteredTickets = tickets
        self.tableView.reloadData()
        self.emptyStateControl()
        self.dismiss(animated: true, completion: nil)
    }
}

extension PromotionUsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredTickets = self.tickets
        
        if !searchText.isEmpty {
            self.filteredTickets = self.filteredTickets.filter({ ticket in
                guard let user = ticket.email_user else { return false }
                return user.email.lowercased().contains(searchText.lowercased())
            })
        }
        
        tableView.reloadData()
        self.emptyStateControl()
    }
}

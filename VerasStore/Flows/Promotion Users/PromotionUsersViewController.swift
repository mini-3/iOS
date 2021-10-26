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
    
    private var tickets: [Ticket] = []
    private var filteredTickets: [Ticket] = []
    private let presenter = PromotionUsersPresenter()
    var promotionId = 1
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Clientes"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        presenter.view = self
        self.addSubviews()
        self.addConstraints()
        presenter.fetch(promotionId: promotionId)
        let presenter = PromotionPresenter()
        presenter.create(name: "Promoção de aniversário", ticketType: "almoço", winTicketAmount: 5, award: "Um almoço", start: Date(), end: Date(), storeId: 3)
    }
    
    // MARK: - Functionalities
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
    }
}

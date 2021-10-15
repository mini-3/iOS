//
//  UserPromotionsViewController.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 14/10/21.
//

import UIKit

class UserPromotionsViewController: UIViewController {
    
    //MARK: - Subviews
    private let userPromotionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserPromotionsTableViewCell.self, forCellReuseIdentifier: UserPromotionsTableViewCell.identifier)
        return tableView
    }()
    
    private var userPromotionTickets: [UserPromotionTicketsResponse] = []
    private let presenter = UserPresenter()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.addSubviews()
        self.addConstraints()
        self.userPromotionsTableView.dataSource = self
        self.userPromotionsTableView.separatorStyle = .none
        self.presenter.view = self
        self.presenter.fetchUserTicketofPromotion()
    }
    
    //MARK: - Functionalities
    private func configureUI() {
        title = "Your name"
        self.userPromotionsTableView.backgroundColor = UIColor(named: "Background")
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func addSubviews() {
        view.addSubview(userPromotionsTableView)
    }
    
    private func addConstraints() {
        let tableViewConstraints = [
            userPromotionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userPromotionsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            userPromotionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userPromotionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }

}

extension UserPromotionsViewController: UserPresenterDelegate {
    func fetched(response: [UserPromotionTicketsResponse]) {
        self.userPromotionTickets = response
        DispatchQueue.main.async {
            self.userPromotionsTableView.reloadData()
        }
    }
}

extension UserPromotionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.userPromotionTickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserPromotionsTableViewCell.identifier) as? UserPromotionsTableViewCell else {
            return UITableViewCell()
        }
        let userPromotionTicket = userPromotionTickets[indexPath.row]
        guard let model = userPromotionTicket.promotion else { return UITableViewCell() }
        cell.configure(storeName: "Loja do fulano", ticketCount: "\(userPromotionTicket.ticketAmount)/\(model.win_ticket_amount)", awardPrize: "Vale \(model.award)", awardAmount: model.win_ticket_amount, currentAmount: userPromotionTicket.ticketAmount)
        cell.selectionStyle = .none
        return cell
    }
}
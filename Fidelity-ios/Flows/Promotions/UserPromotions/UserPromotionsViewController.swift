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
    
<<<<<<< HEAD
    private var userPromotionTickets: [UserPromotionTicketsResponse] = []
=======
    private let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Em andamento", "Finalizados"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.selectedSegmentIndex = 0
        return segmented
    }()
    
    private var userPromotionTickets: [UserPromotionTicketsResponse] = []
    private var userPromotionTicketsFiltered: [UserPromotionTicketsResponse] = []
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
    private let presenter = UserPresenter()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.addSubviews()
<<<<<<< HEAD
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
=======
        self.configureTableView()
        self.addConstraints()
        segmentedControl.addTarget(self, action: #selector(didChangedSegmented(_:)), for: .valueChanged)
    }
    
    //MARK: - Functionalities
    private func configureTableView() {
        self.userPromotionsTableView.tableHeaderView = segmentedControl
        self.userPromotionsTableView.dataSource = self
        self.userPromotionsTableView.separatorStyle = .none
        self.userPromotionsTableView.backgroundColor = UIColor(named: "Background")
    }
    
    private func configureUI() {
        title = "Promoções"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.presenter.view = self
        self.presenter.fetchUserTicketofPromotion()
    }
    
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
    private func addSubviews() {
        view.addSubview(userPromotionsTableView)
    }
    
    private func addConstraints() {
<<<<<<< HEAD
=======
        let segmentedConstraints = [
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedControl.superview!.centerXAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControl.superview!.leadingAnchor, constant: 32),
        ]
        
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        let tableViewConstraints = [
            userPromotionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userPromotionsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            userPromotionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userPromotionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
<<<<<<< HEAD
        NSLayoutConstraint.activate(tableViewConstraints)
=======
        
        NSLayoutConstraint.activate(tableViewConstraints)
        NSLayoutConstraint.activate(segmentedConstraints)
    }
    
    // MARK: - Objc
    @objc private func didChangedSegmented(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.userPromotionTicketsFiltered = self.userPromotionTickets.filter {
                guard let promotion = $0.promotion else { return false }
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                guard let date = formatter.date(from: promotion.end) else { return false }
                return date >= Date()
            }
        } else {
            self.userPromotionTicketsFiltered = self.userPromotionTickets.filter {
                guard let promotion = $0.promotion else { return false }
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                guard let date = formatter.date(from: promotion.end) else { return false }
                return date < Date()
            }
        }
        userPromotionsTableView.reloadData()
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
    }

}

extension UserPromotionsViewController: UserPresenterDelegate {
    func fetched(response: [UserPromotionTicketsResponse]) {
        self.userPromotionTickets = response
<<<<<<< HEAD
=======
        self.userPromotionTicketsFiltered = response.filter {
            guard let promotion = $0.promotion else { return false }
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            guard let date = formatter.date(from: promotion.end) else { return false }
            return date >= Date()
        }
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        DispatchQueue.main.async {
            self.userPromotionsTableView.reloadData()
        }
    }
}

extension UserPromotionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD
        self.userPromotionTickets.count
=======
        return self.userPromotionTicketsFiltered.count
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserPromotionsTableViewCell.identifier) as? UserPromotionsTableViewCell else {
            return UITableViewCell()
        }
<<<<<<< HEAD
        let userPromotionTicket = userPromotionTickets[indexPath.row]
        guard let model = userPromotionTicket.promotion else { return UITableViewCell() }
        cell.configure(storeName: "Loja do fulano", ticketCount: "\(userPromotionTicket.ticketAmount)/\(model.win_ticket_amount)", awardPrize: "Vale \(model.award)", awardAmount: model.win_ticket_amount, currentAmount: userPromotionTicket.ticketAmount)
=======
        let userPromotionTicket = userPromotionTicketsFiltered[indexPath.row]
        guard let model = userPromotionTicket.promotion else { return UITableViewCell() }
        let viewModel = PromotionViewModel(with: model)
        cell.configure(storeName: viewModel.storeName, ticketCount: "\(userPromotionTicket.ticketAmount)/\(model.win_ticket_amount)", awardPrize: viewModel.award, awardAmount: model.win_ticket_amount, currentAmount: userPromotionTicket.ticketAmount, dateEnd: viewModel.endDateString)
>>>>>>> 94b3bea20e934891d1672dbc41f0708029738bbf
        cell.selectionStyle = .none
        return cell
    }
}

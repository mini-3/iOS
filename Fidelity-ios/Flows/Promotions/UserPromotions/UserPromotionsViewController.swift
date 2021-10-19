//
//  UserPromotionsViewController.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 14/10/21.
//

import UIKit
import Combine

class UserPromotionsViewController: UIViewController {
    
    //MARK: - Subviews
    private let userPromotionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserPromotionsTableViewCell.self, forCellReuseIdentifier: UserPromotionsTableViewCell.identifier)
        return tableView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Em andamento", "Finalizados"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.selectedSegmentIndex = 0
        return segmented
    }()
    
    private var userPromotionTickets: [UserPromotionTicketsResponse] = []
    private var userPromotionTicketsFiltered: [UserPromotionTicketsResponse] = []
    private let presenter = UserPresenter()
    private var cancellables: [AnyCancellable] = []

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.addSubviews()
        self.configureTableView()
        self.addConstraints()
        self.configureObservers()
        segmentedControl.addTarget(self, action: #selector(didChangedSegmented(_:)), for: .valueChanged)
    }
    
    deinit{
        cancellables.forEach{
            $0.cancel()
        }
    }
    
    //MARK: - Functionalities
    private func configureTableView() {
        self.userPromotionsTableView.tableHeaderView = segmentedControl
        self.userPromotionsTableView.dataSource = self
        self.userPromotionsTableView.separatorStyle = .none
        self.userPromotionsTableView.backgroundColor = UIColor(named: "Background")
    }
    
    private func configureObservers() {
        SyncService.shared.$ticketSync.sink { _ in
            self.presenter.fetchUserTicketofPromotion()
        }
        .store(in: &cancellables)
    }
    
    private func configureUI() {
        title = "Promoções"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.presenter.view = self
        self.presenter.fetchUserTicketofPromotion()
    }
    
    private func addSubviews() {
        view.addSubview(userPromotionsTableView)
    }
    
    private func addConstraints() {
        let segmentedConstraints = [
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedControl.superview!.centerXAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControl.superview!.leadingAnchor, constant: 32),
        ]
        
        let tableViewConstraints = [
            userPromotionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userPromotionsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            userPromotionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userPromotionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
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
    }

}

extension UserPromotionsViewController: UserPresenterDelegate {
    func fetched(response: [UserPromotionTicketsResponse]) {
        self.userPromotionTickets = response
        self.userPromotionTicketsFiltered = response.filter {
            guard let promotion = $0.promotion else { return false }
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            guard let date = formatter.date(from: promotion.end) else { return false }
            return date >= Date()
        }
        DispatchQueue.main.async {
            self.userPromotionsTableView.reloadData()
        }
    }
}

extension UserPromotionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userPromotionTicketsFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserPromotionsTableViewCell.identifier) as? UserPromotionsTableViewCell else {
            return UITableViewCell()
        }
        let userPromotionTicket = userPromotionTicketsFiltered[indexPath.row]
        guard let model = userPromotionTicket.promotion else { return UITableViewCell() }
        let viewModel = PromotionViewModel(with: model)
        cell.configure(storeName: viewModel.storeName, ticketCount: "\(userPromotionTicket.ticketAmount)/\(model.win_ticket_amount)", awardPrize: viewModel.award, awardAmount: model.win_ticket_amount, currentAmount: userPromotionTicket.ticketAmount, dateEnd: viewModel.endDateString)
        cell.selectionStyle = .none
        return cell
    }
}

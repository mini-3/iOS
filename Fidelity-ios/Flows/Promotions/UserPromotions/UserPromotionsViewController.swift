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
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "Background")
        
        return tableView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Em andamento", "Finalizados"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.selectedSegmentIndex = 0
        
        return segmented
    }()
    
    private var emptyState: EmptyStateTableView = {
        let empty = EmptyStateTableView(image: UIImage(systemName: "ticket.fill")!, label: "Você ainda não está participando de nenhuma promoção. Visite nossos estabelecimentos parceiros!")
        empty.translatesAutoresizingMaskIntoConstraints = false
        
        return empty
    }()
    
    private var userPromotionTickets: [UserPromotionTicketsResponse] = []
    private var userPromotionTicketsFiltered: [UserPromotionTicketsResponse] = []
    private let userPresenter = UserPresenter()
    private let ticketPresenter = TicketPresenter()
    private var cancellables: [AnyCancellable] = []

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.addSubviews()
        self.configureTableView()
        self.addConstraints()
        self.configureObservers()
        self.configureRefresh()
        self.emptyStateControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.userPresenter.fetchUserTicketofPromotion()
    }
    
    deinit{
        cancellables.forEach{ $0.cancel() }
    }
    
    //MARK: - Functionalities
    private func configureTableView() {
        self.userPromotionsTableView.dataSource = self
        self.userPromotionsTableView.delegate = self
    }
    
    private func configureRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        self.userPromotionsTableView.refreshControl = refresh
    }
    
    private func configureObservers() {
        SyncService.shared.$ticketSync.sink { _ in
            self.userPresenter.fetchUserTicketofPromotion()
        }
        .store(in: &cancellables)
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Promoções"
        navigationController?.navigationBar.prefersLargeTitles = true
        let gearButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(gearButtonAction))
        navigationItem.rightBarButtonItem = gearButton
        self.userPresenter.view = self
        segmentedControl.addTarget(self, action: #selector(didChangedSegmented(_:)), for: .valueChanged)
    }
    
    private func addSubviews() {
        view.addSubview(segmentedControl)
        view.addSubview(userPromotionsTableView)
        view.addSubview(emptyState)
    }
    
    private func addConstraints() {
        let segmentedControlConstraints = [
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedControl.superview!.centerXAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControl.superview!.leadingAnchor, constant: 32),
            segmentedControl.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32)
        ]
        
        let tableViewConstraints = [
            userPromotionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userPromotionsTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 32),
            userPromotionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userPromotionsTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ]
        
        let emptyStateConstraints = [
            emptyState.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyState.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyState.heightAnchor.constraint(equalToConstant: 300),
            emptyState.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        NSLayoutConstraint.activate(segmentedControlConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)
        NSLayoutConstraint.activate(emptyStateConstraints)
    }
    
    private func emptyStateControl() {
        if userPromotionTicketsFiltered.count == 0 {
            emptyState.isHidden = false
            userPromotionsTableView.isHidden = true
        } else {
            emptyState.isHidden = true
            userPromotionsTableView.isHidden = false
        }
    }
    
    private func filterData() {
        if self.segmentedControl.selectedSegmentIndex == 0 {
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
    }
    
    // MARK: - Objc
    @objc private func didRefresh() {
        self.userPresenter.fetchUserTicketofPromotion(withLoadingScreen: false)
    }
    
    @objc private func gearButtonAction() {
        let configVC = ConfigurationViewController()
        configVC.modalPresentationStyle = .automatic
        let navVC = UINavigationController(rootViewController: configVC)
        navVC.modalPresentationStyle = .automatic
        self.present(navVC, animated: true)
    }
    
    @objc private func didChangedSegmented(_ sender: UISegmentedControl) {
        self.filterData()
        userPromotionsTableView.reloadData()
        self.emptyStateControl()
    }

}

extension UserPromotionsViewController: UserPresenterDelegate {
    func fetched(response: [UserPromotionTicketsResponse]) {
        self.userPromotionTickets = response
        self.userPromotionTicketsFiltered = response
        DispatchQueue.main.async {
            self.filterData()
            self.userPromotionsTableView.reloadData()
            self.emptyStateControl()
            self.userPromotionsTableView.refreshControl?.endRefreshing()
        }
    }
}

extension UserPromotionsViewController: UITableViewDataSource, UITableViewDelegate {
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
        cell.configure(storeName: viewModel.storeName, ticketCount: "\(userPromotionTicket.ticketAmount)/\(model.win_ticket_amount)", avatar: viewModel.image, awardPrize: viewModel.award, awardAmount: model.win_ticket_amount, currentAmount: userPromotionTicket.ticketAmount, dateEnd: viewModel.endDateString, code: model.code)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userPromotionTicket = userPromotionTicketsFiltered[indexPath.row]
        guard let model = userPromotionTicket.promotion else { return }
        
        if model.win_ticket_amount <= userPromotionTicket.ticketAmount && userPromotionTicket.ticketAmount > 0 && model.win_ticket_amount > 0 {
            let wonVC = WonViewControler()
            wonVC.delegate = self
            wonVC.userPromotionTicket = model
            wonVC.modalPresentationStyle = .automatic
            let navVC = UINavigationController(rootViewController: wonVC)
            navVC.modalPresentationStyle = .automatic
            self.present(navVC, animated: true, completion: nil)
        }
    }
}

extension UserPromotionsViewController: WonViewControllerDelegate {
    func dismissed() {
        self.userPresenter.fetchUserTicketofPromotion()
    }
}

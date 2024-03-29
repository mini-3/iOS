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
        label.text = "Estabelecimento"
        
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
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private var emptyState: EmptyStateTableView = {
        let empty = EmptyStateTableView(image: UIImage(systemName: "ticket.fill")!, label: "O estabelecimento ainda não possui promoções. Crie promoções e fidelize seus clientes")
        empty.translatesAutoresizingMaskIntoConstraints = false
        
        return empty
    }()
    
    var promotions: [PromotionViewModel] = []
    var filteredPromotions: [PromotionViewModel] = []
    var withLoadingScreen = true
    private let promotionPresenter = PromotionPresenter()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        promotionsTableView.dataSource = self
        promotionsTableView.delegate = self
        self.promotionPresenter.view = self
        
        self.configureUI()
        self.configureSubViews()
        self.configureConstraints()
        self.configureStacks()
        self.configureRefresh()
        self.emptyStateControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.promotionPresenter.fetch(withLoadingScreen: withLoadingScreen)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Functionalities
    
    private func configureUI() {
        view.backgroundColor = UIColor(named: "Background")
        navigationController?.navigationBar.prefersLargeTitles = false
        
        verticalStackView.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        storeLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        
        segmentedControl.addTarget(self, action: #selector(didChangedSegmented(_:)), for: .valueChanged)
        
        let gearButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(gearButtonAction))
        navigationItem.rightBarButtonItem = gearButton
        let cameraButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(scannerButtonAction))
        navigationItem.leftBarButtonItem = cameraButton
    }
    
    private func configureSubViews() {
        view.addSubview(horizontalStackView)
        view.addSubview(segmentedControl)
        view.addSubview(promotionsTableView)
        view.addSubview(emptyState)
    }
    
    private func configureConstraints() {
        let horizontalStackViewConstraints = [
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            horizontalStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 22)
        ]
        
        let segmentedControlConstraints = [
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedControl.superview!.centerXAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControl.superview!.leadingAnchor, constant: 32),
            segmentedControl.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 32)
        ]
        
        let promotionsTableViewConstraints = [
            promotionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            promotionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            promotionsTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 32),
            promotionsTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ]
        
        let emptyStateConstraints = [
            emptyState.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyState.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyState.heightAnchor.constraint(equalToConstant: 250),
            emptyState.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        NSLayoutConstraint.activate(horizontalStackViewConstraints)
        NSLayoutConstraint.activate(segmentedControlConstraints)
        NSLayoutConstraint.activate(promotionsTableViewConstraints)
        NSLayoutConstraint.activate(emptyStateConstraints)
    }
    
    private func configureStacks() {
        horizontalStackView.addArrangedSubview(storeLabel)
        horizontalStackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(customersLabel1)
        verticalStackView.addArrangedSubview(customersLabel2)
    }
    
    private func emptyStateControl() {
        if filteredPromotions.count == 0 {
            emptyState.isHidden = false
            promotionsTableView.isHidden = true
        } else {
            emptyState.isHidden = true
            promotionsTableView.isHidden = false
        }
    }
    
    private func configureRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        self.promotionsTableView.refreshControl = refresh
    }
    
    private func filterData() {
        if self.segmentedControl.selectedSegmentIndex == 1 {
            self.filteredPromotions = self.promotions.filter {
                guard let promotion = $0.promotion else { return false }
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                guard let date = formatter.date(from: promotion.end) else { return false }
                return date < Date()
            }
        } else {
            self.filteredPromotions = self.promotions.filter {
                guard let promotion = $0.promotion else { return false }
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                guard let date = formatter.date(from: promotion.end) else { return false }
                return date >= Date()
            }
        }
    }
    
    // MARK: - Objc
    
    @objc private func didRefresh() {
        self.promotionPresenter.fetch(withLoadingScreen: false)
    }
    
    @objc private func didChangedSegmented(_ sender: UISegmentedControl) {
        self.filterData()
        promotionsTableView.reloadData()
        self.emptyStateControl()
    }
    
    @objc private func gearButtonAction() {
        let configVC = StoreConfigurationViewController()
        configVC.modalPresentationStyle = .automatic
        let navVC = UINavigationController(rootViewController: configVC)
        navVC.modalPresentationStyle = .automatic
        self.present(navVC, animated: true)
    }
    
    @objc private func scannerButtonAction() {
        let vc = QRcodeReaderViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StorePromotionsViewController: PromotionPresenterDelegate {
    func fetched(promotions: [PromotionViewModel]) {
        self.promotions = promotions
        self.filteredPromotions = promotions
        DispatchQueue.main.async {
            self.filterData()
            self.promotionsTableView.reloadData()
            self.emptyStateControl()
            self.promotionsTableView.refreshControl?.endRefreshing()
        }
    }
}

extension StorePromotionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredPromotions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StorePromotionsTableViewCell.identifier) as? StorePromotionsTableViewCell else {
            return UITableViewCell()
        }
        
        let promotion = filteredPromotions[indexPath.row]
        guard let model = promotion.promotion else { return UITableViewCell() }
        
        cell.configure(promotionName: model.name, avatar: model.store?.avatar ?? "photo.circle", promotionAward: model.award, amount: model.win_ticket_amount, promotionId: model.id, dateEnd: promotion.endDateString)
        cell.selectionStyle = .none
        cell.delegate = self
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let promotion = filteredPromotions[indexPath.row]
        let vc = StoreFidelityDetailsViewController()
        guard let model = promotion.promotion else { return }
        vc.promotionId = model.id
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension StorePromotionsViewController: StorePromotionsTableViewCellDelegate {
    func didTapQrCodeButton(cell: UITableViewCell) {
        guard let indexPath = promotionsTableView.indexPath(for: cell) else { return }
        let promotion = filteredPromotions[indexPath.row]
        
        let vc = GenerateTicketViewController()
        vc.promotion = promotion
        navigationController?.pushViewController(vc, animated: true)
    }
}

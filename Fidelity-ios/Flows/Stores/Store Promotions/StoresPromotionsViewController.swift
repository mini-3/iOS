//
//  UserPromotiosView.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 13/10/21.
//

import Foundation
import UIKit

class StoresPromotionsViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.placeholder = "Buscar"
        
        return searchController
        
    }()
    
    private lazy var storesTableView: UITableView = {
        let storesTableView = UITableView()
        storesTableView.translatesAutoresizingMaskIntoConstraints = false
        return storesTableView
    }()
    
    private var emptyState: EmptyStateTableView = {
        let empty = EmptyStateTableView(image: UIImage(systemName: "creditcard.fill")!, label: "Ainda não existem estabelecimentos parceiros na sua região.")
        empty.translatesAutoresizingMaskIntoConstraints = false
        
        return empty
    }()
    
    private let promotionPresenter: PromotionPresenter = PromotionPresenter()
    var promotions: [PromotionViewModel] = []
    var filteredData: [PromotionViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.promotionPresenter.view = self
        self.configureUI()
        self.configureSubViews()
        self.configureConstraints()
        self.configureRefresh()
        self.promotionPresenter.fetchPromotions()
        searchController.searchBar.delegate = self
    }
    
    private func configureUI() {
        title = "Fidelidades"
        self.view.backgroundColor = UIColor(named: "Background")
        self.storesTableView.backgroundColor = UIColor(named: "Background")
        storesTableView.register(StoresPromotionsTableViewCell.self, forCellReuseIdentifier: StoresPromotionsTableViewCell.identifier)
        storesTableView.delegate = self
        storesTableView.dataSource = self
        storesTableView.separatorStyle = .none
        navigationItem.searchController = searchController
        self.emptyStateControl()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.storesTableView.refreshControl = refresh
    }
    
    func configureSubViews() {
        view.addSubview(storesTableView)
        view.addSubview(emptyState)
    }
    
    func configureConstraints() {
        
        let storesTableViewConstraints = [
            storesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            storesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            storesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            storesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let emptyStateConstraints = [
            emptyState.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyState.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyState.heightAnchor.constraint(equalToConstant: 300),
            emptyState.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        NSLayoutConstraint.activate(storesTableViewConstraints)
        NSLayoutConstraint.activate(emptyStateConstraints)
    }
    
    func emptyStateControl() {
        if filteredData.count == 0 {
            emptyState.isHidden = false
            storesTableView.isHidden = true
        } else {
            emptyState.isHidden = true
            storesTableView.isHidden = false
        }
    }
    
    @objc func handleRefresh() {
        promotionPresenter.fetchPromotions()
    }
    
}

extension StoresPromotionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = storesTableView.dequeueReusableCell(withIdentifier: StoresPromotionsTableViewCell.identifier) as? StoresPromotionsTableViewCell else { return UITableViewCell() }
        let viewModel = self.filteredData[indexPath.row]
        
        cell.configure(storeImage: viewModel.promotion?.store?.avatar ?? "photo.circle", storeName: viewModel.promotion?.store?.name ?? "Loja", storePromotionDescription: viewModel.awardPhraseBuild())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width - 40, height: headerView.frame.height - 20)
        label.text = "Lojas"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = filteredData[indexPath.row]
        let storeDetailsVC = StoreDetailsViewController()
        storeDetailsVC.promotion = viewModel
        storeDetailsVC.modalPresentationStyle = .automatic
        let navVc = UINavigationController(rootViewController: storeDetailsVC)
        navVc.modalPresentationStyle = .automatic
        self.present(navVc, animated: true, completion: nil)
    }
    
}

extension StoresPromotionsViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        promotionPresenter.fetchPromotions()
        self.storesTableView.reloadData()
        self.emptyStateControl()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = promotions
        
        if !searchText.isEmpty {
            filteredData = promotions.filter{ $0.storeName.lowercased().contains(searchText.lowercased()) || $0.award.lowercased().contains(searchText.lowercased())}
            self.storesTableView.reloadData()
            self.emptyStateControl()
        }
        
    }
}

extension StoresPromotionsViewController: PromotionPresenterDelegate {
    func fetched(promotions: [PromotionViewModel]) {
        self.filteredData = promotions
        self.promotions = promotions
        DispatchQueue.main.async {
            self.storesTableView.reloadData()
            self.emptyStateControl()
            self.storesTableView.refreshControl?.endRefreshing()
        }
    }
}

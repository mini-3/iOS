//
//  UserPromotiosView.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 13/10/21.
//

import Foundation
import UIKit

class StoresPromotionsViewController: UIViewController {
    
    private let promotionPresenter: PromotionPresenter = PromotionPresenter()
    //private let categories:
    var promotions: [PromotionViewModel] = []
    var filteredData: [PromotionViewModel] = []
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchController
        
    }()
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let categoriesCollectionView = UICollectionView()
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.isScrollEnabled = true
        
        
        return categoriesCollectionView
    }()
    
    private lazy var storesTableView: UITableView = {
        let storesTableView = UITableView()
        storesTableView.translatesAutoresizingMaskIntoConstraints = false
        return storesTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.promotionPresenter.view = self
        configureUI()
        configureSubViews()
        configureConstraints()
        self.promotionPresenter.fetchPromotions()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Buscar"
        navigationItem.searchController = searchController
        
    }
    
    private func configureUI() {
        title = "Fidelidades"
        self.view.backgroundColor = UIColor(named: "Background")
        self.storesTableView.backgroundColor = UIColor(named: "Background")
        storesTableView.register(StoresPromotionsTableViewCell.self, forCellReuseIdentifier: StoresPromotionsTableViewCell.identifier)
        storesTableView.delegate = self
        storesTableView.dataSource = self
        storesTableView.separatorStyle = .none
        //        let refreshable = UIRefreshControl()
        //
        //        storesTableView.refreshControl = refreshable
        //        storesTableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureSubViews() {
        view.addSubview(storesTableView)
        
    }
    
    func configureConstraints() {
        
        let storesTableViewConstraints = [
            storesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            storesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            storesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            storesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
        ]
        
        NSLayoutConstraint.activate(storesTableViewConstraints)
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
        
        cell.configure(storeImage: "", storeName: viewModel.promotion?.store?.name ?? "Loja", storePromotionDescription: viewModel.awardPhraseBuild())
        
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
        //TO DO
        // ir para a tela de detalhes com a promo
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
    
    //    var isEmptyFiltering: Bool {
    //        promotions.map{$1}.reduce([],+).count < 1
    //    }
    //
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        promotionPresenter.fetchPromotions()
        self.storesTableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        filteredData = promotions
        
        if !searchText.isEmpty {
            filteredData = promotions.filter{ $0.storeName.lowercased().contains(searchText.lowercased()) || $0.award.lowercased().contains(searchText.lowercased())}
            self.storesTableView.reloadData()
            
        }
        
    }
}

//extension UserStoresViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//}

extension StoresPromotionsViewController: PromotionPresenterDelegate {
    func fetched(promotions: [PromotionViewModel]) {
        self.filteredData = promotions
        self.promotions = promotions
        DispatchQueue.main.async {
            self.storesTableView.reloadData()
        }
    }
}

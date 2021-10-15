//
//  UserPromotiosView.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 13/10/21.
//

import Foundation
import UIKit
import Combine

class UserStoresViewController: UIViewController {
    
    private let storePresenter: StorePresenter = StorePresenter()
    //private let categories:
    private var stores: [StoreViewModel] = []
    
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
        self.storePresenter.view = self
        view.backgroundColor = UIColor(named: "background")
        configureUI()
        configureSubViews()
        configureConstraints()
        self.storePresenter.fetchStores()
        searchController.searchBar.placeholder = "test"
        navigationItem.titleView = searchController.searchBar
        
    }
    
    private func configureUI() {
        title = "Fidelidades"
        storesTableView.register(StoresTableViewCell.self, forCellReuseIdentifier: StoresTableViewCell.identifier)
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
        view.addSubview(searchController.searchBar)
        //view.addSubview(categoriesCollectionView)
        view.addSubview(storesTableView)
    }
    
    func configureConstraints() {
        let searchBarContrainsts = [
            searchController.searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchController.searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchController.searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        ]
        
        let storesTableViewConstraints = [
            storesTableView.topAnchor.constraint(equalTo: searchController.searchBar.topAnchor),
            storesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            storesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            storesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
        ]
        
        NSLayoutConstraint.activate(searchBarContrainsts)
        NSLayoutConstraint.activate(storesTableViewConstraints)
    }
    
    @objc func handleRefresh() {
        storePresenter.fetchStores()
    }
    
}

extension UserStoresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(stores.count)
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = storesTableView.dequeueReusableCell(withIdentifier: StoresTableViewCell.identifier) as? StoresTableViewCell else { return UITableViewCell() }
        let viewModel = self.stores[indexPath.row]
        
        cell.configure(storeImage: "", storeName: viewModel.store!.name, storePromotionDescription: "aaa", storeDistance: "2km", storeOpen: "Open")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = stores[indexPath.row]
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

extension UserStoresViewController: StorePresenterDelegate {
    func fetched(stores: [StoreViewModel]) {
        self.stores = stores
        DispatchQueue.main.async {
            self.storesTableView.reloadData()
        }
        
    }
}

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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
        
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
        storePresenter.view = self
        configureSubViews()
        configureConstraints()
    }
    
    private func configureUI() {
        title = "Stores"
        storesTableView.register(StoresTableViewCell.self, forCellReuseIdentifier: StoresTableViewCell.identifier)
//        storesTableView.delegate = self
//        storesTableView.dataSource = self
        storesTableView.separatorStyle = .none
        let refreshable = UIRefreshControl()
        
        storesTableView.refreshControl = refreshable
        storesTableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    func configureSubViews() {
        view.addSubview(searchBar)
        view.addSubview(categoriesCollectionView)
        view.addSubview(storesTableView)
    }
    
    func configureConstraints() {
        
    }
    
    private func fetchStores(withLoadingScreen: Bool = true) {
        storePresenter.fetchStores()
    }
    
    @objc func handleRefresh() {
        storePresenter.fetchStores()
    }
    
}

//extension UserPromotionsViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return stores.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = StoresTableViewCell.dequeueReusableCell(withIdentifier: StoresTableViewCell.identifier) as? StoresTableViewCell else { return UITableViewCell() }
//        let viewModel = self.stores[indexPath.row]
//        cell.configure(image: viewModel.image, title: viewModel.title, date: viewModel.date, participants: viewModel.participants)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewModel = stores[indexPath.row]
//    }
//
//}

extension UserStoresViewController: StorePresenterDelegate {
    func fetched(stores: [StoreViewModel]) {
        self.stores = stores
        self.storesTableView.reloadData()
    }
}

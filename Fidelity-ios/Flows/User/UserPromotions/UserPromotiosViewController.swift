//
//  UserPromotiosView.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 13/10/21.
//

import Foundation
import UIKit
import Combine

class UserPromotionsViewController: UIViewController {
    
    //private let categories:
    //private let stores: [Store]
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
        
    }()
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let categoriesCollectionView = UICollectionView()
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return categoriesCollectionView
    }()
    
    private lazy var storesTableView: UITableView = {
        let storesTableView = UITableView()
        storesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        return storesTableView
    }()
    
    override func viewDidLoad() {
        configureSubViews()
        configureConstraints()
    }
    
    private func configureUI() {
        title = "Events"
        storesTableView.register(StoresTableViewCell.self, forCellReuseIdentifier: StoresTableViewCell.identifier)
        //storesTableView.delegate = self
        //storesTableView.dataSource = self
        storesTableView.separatorStyle = .none
        let refreshable = UIRefreshControl()
        
        storesTableView.refreshControl = refreshable
        //storesTableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    func configureSubViews() {
        view.addSubview(searchBar)
        view.addSubview(categoriesCollectionView)
        view.addSubview(storesTableView)
    }
    
    func configureConstraints() {
        
    }
    
//    private func fetchEvents(withLoadingScreen: Bool = true) {
//        presenter.fetchEvents(withLoadingScreen: withLoadingScreen)
//    }
    
//    extension UserPromotionsViewController: UITableViewDelegate, UITableViewDataSource {
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return events.count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = eventsTableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier) as? EventTableViewCell else { return UITableViewCell() }
//            let viewModel = self.events[indexPath.row]
//            cell.configure(image: viewModel.image, title: viewModel.title, date: viewModel.date, participants: viewModel.participants)
//            return cell
//        }
//
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let viewModel = events[indexPath.row]
//            coordinator?.eventOccurred(with: .goToEventDetails(viewModel: viewModel))
//        }
//
//    }
}

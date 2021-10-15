//
//  MainTabBarViewController.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 08/10/21.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let userPromotionsVC = UserPromotionsViewController()
        let storesVC = StoreDetailsViewController()
        
        let nav1 = UINavigationController(rootViewController: userPromotionsVC)
        let nav2 = UINavigationController(rootViewController: storesVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Promotions", image: UIImage(systemName: "ticket.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Stores", image: UIImage(systemName: "creditcard.fill"), tag: 2)
        
        self.setViewControllers([nav1, nav2], animated: false)
    }

}

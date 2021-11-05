//
//  StoreMainTabBarViewController.swift
//  VerasStore
//
//  Created by Matheus Homrich on 28/10/21.
//

import Foundation
import UIKit

class StoreMainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let newFidelityVC = CreateUpdatePromotionViewController()
        newFidelityVC.configure(type: .create, promotion: nil)
        let storePromotionsVC = StorePromotionsViewController()
        
        let nav1 = UINavigationController(rootViewController: newFidelityVC)
        let nav2 = UINavigationController(rootViewController: storePromotionsVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Nova Fidelidade", image: UIImage(named: "Nova Fidelidade"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Fidelidades", image: UIImage(named: "Fidelidades"), tag: 2)
        
        self.setViewControllers([nav1, nav2], animated: false)
    }

}

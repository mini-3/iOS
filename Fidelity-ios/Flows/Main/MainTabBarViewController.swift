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
        
        let userPromotions = UserPromotionsViewController()
        
        let nav1 = UINavigationController(rootViewController: userPromotions)
        
        nav1.tabBarItem = UITabBarItem(title: "Promotions", image: UIImage(systemName: "ticket"), tag: 1)
        
        self.setViewControllers([nav1], animated: true)
    }

}

//
//  HomeTabBarController.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setTabBarItemImages()
        setTabItemsTextColors()
    }
    
    func setTabBarItemImages() {
        self.tabBar.items?[0].image = UIImage(named: "tab-explore")
        self.tabBar.items?[0].selectedImage = UIImage(named: "tab-explore")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[1].image = UIImage(named: "star-white")
        self.tabBar.items?[1].selectedImage = UIImage(named: "tab-star")
    }
    
    func setTabItemsTextColors() {
        let unselectedItem: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let selectedItem: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.red]
        
        self.tabBar.items?[0].setTitleTextAttributes(unselectedItem as? [NSAttributedString.Key : Any], for: .normal)
        self.tabBar.items?[0].setTitleTextAttributes(selectedItem as? [NSAttributedString.Key : Any], for: .highlighted)
        
        self.tabBar.items?[1].setTitleTextAttributes(unselectedItem as? [NSAttributedString.Key : Any], for: .normal)
        self.tabBar.items?[1].setTitleTextAttributes(selectedItem as? [NSAttributedString.Key : Any], for: .highlighted)
    }
}

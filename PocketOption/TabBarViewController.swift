//
//  TabBarViewController.swift
//  Avix
//
//  Created by Ravil on 14.11.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addedTabBarSetup()
    }
        
    private func addedTabBarSetup() {
        let chartsViewController = ChartsViewController()
        let articlesViewController = UINavigationController(rootViewController: ArticlesViewController())
        let newsViewController = UINavigationController(rootViewController: NewsViewController())
        let settingViewController = UINavigationController(rootViewController: SettingsViewController())
        
        tabBar.backgroundColor = Burger.tabbarBack.uiColor
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.layer.cornerRadius = 20
        
        chartsViewController.tabBarItem = UITabBarItem(
            title: "", image: UIImage(named: "tab1Non"),
            selectedImage: UIImage(named: "tab1")
        )
        
        articlesViewController.tabBarItem = UITabBarItem(
            title: "", image: UIImage(named: "tab2Non"),
            selectedImage: UIImage(named: "tab2")
        )

        newsViewController.tabBarItem = UITabBarItem(
            title: "", image: UIImage(named: "tab3Non"),
            selectedImage: UIImage(named: "tab3")
        )
        
        settingViewController.tabBarItem = UITabBarItem(
            title: "", image: UIImage(named: "tab4Non"),
            selectedImage: UIImage(named: "tab4")
        )
        
        viewControllers = [chartsViewController, articlesViewController, newsViewController, settingViewController]
    }
}

//
//  AppStartBuilder.swift
//  Pizza
//
//  Created by Артур Кондратьев on 03.04.2023.
//

import UIKit

class AppStartBuilder {
    
    static func builder() -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.backgroundColor = .systemGray6
        tabBarVC.tabBar.barTintColor = .systemGray6
        tabBarVC.tabBar.tintColor = .red
        
        let menuVC = UINavigationController(rootViewController: MenuVcBuilder.createMenuModul())
        menuVC.title = "Меню"
        
        let contactsVC = UINavigationController(rootViewController: ContactVC())
        contactsVC.title = "Контакты"
        
        let prifilVC = UINavigationController(rootViewController: ProfilVC())
        prifilVC.title = "Профиль"
        
        let cartVC = UINavigationController(rootViewController: CartVC())
        cartVC.title = "Корзина"
        
        tabBarVC.setViewControllers([menuVC, contactsVC, prifilVC, cartVC], animated: true)
        
        let images = ["Menu", "Pin", "Person", "Cart"]
        if let items = tabBarVC.tabBar.items {
            for x in 0..<items.count {
                items[x].image = UIImage(named: images[x])
            }
        }
        
        return tabBarVC
    }
}



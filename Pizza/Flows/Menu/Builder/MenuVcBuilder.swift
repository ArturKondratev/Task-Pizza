//
//  MenuVcBuilder.swift
//  Pizza
//
//  Created by Артур Кондратьев on 04.04.2023.
//

import UIKit

protocol Builder {
    static func createMenuModul() -> UIViewController
}

class MenuVcBuilder: Builder {
    static func createMenuModul() -> UIViewController {
        let networkManager = NetworkManager()
        let view = MenuViewController()
        let presenter = MenuVcPresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        return view
    }
}

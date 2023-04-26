//
//  MainVcPresenter.swift
//  Pizza
//
//  Created by Артур Кондратьев on 04.04.2023.
//

import Foundation
import UIKit

protocol MenuViewProtocol: AnyObject {
    func setDiscontProduct(data: [String])
    func setAllProducts(data: [ProductModel])
    func setProdyctTypes(data: [ProductType])
    func reloadData()
}

protocol MenuVcPresenterProtocol: AnyObject {
    init(view: MenuViewProtocol, networkManager: NetworkManagerProtocol)
    func viewDidLoad()
    func loadImage(for imageView: UIImageView, imageName: String)
}

class MenuVcPresenter: MenuVcPresenterProtocol {
    //MARK: - Propertis
    let view: MenuViewProtocol
    var networkManager: NetworkManagerProtocol
    
    //MARK: - Init
    required init(view: MenuViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    //MARK: - Functions
    func viewDidLoad() {
        defer {
            view.reloadData()
        }
        view.setDiscontProduct(data: networkManager.getDiscontProduct())
        view.setProdyctTypes(data: networkManager.getProductType())
        
        networkManager.getData { allData in
            guard let data = allData else { return }
            self.view.setAllProducts(data: data)
        }
    }
    
    func loadImage(for imageView: UIImageView, imageName: String) {
        networkManager.getImage(picName: imageName) { pic in
            DispatchQueue.main.async {
                imageView.image = pic
            }
        }
    }
}

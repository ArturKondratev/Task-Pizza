//
//  MenuViewController.swift
//  Pizza
//
//  Created by Артур Кондратьев on 03.04.2023.
//

import UIKit

class MenuViewController: UIViewController {
    //MARK: - Propertis
    var discontProduct = [String]()
    var allProducts = [ProductModel]() {
        didSet {
            menuView.tableView.reloadData()
        }
    }
    var prodyctTypes = [ProductType]()
    var presenter: MenuVcPresenterProtocol!
    var menuView: MenuView {
        return self.view as! MenuView
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = MenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        menuView.tableView.delegate = self
        menuView.tableView.dataSource = self
        menuView.collectionView.dataSource = self
        menuView.collectionView.delegate = self
        presenter.viewDidLoad()
    }
}

//MARK: - MenuViewProtocol
extension MenuViewController: MenuViewProtocol {
    func setDiscontProduct(data: [String]) {
        self.discontProduct = data
    }
    
    func setAllProducts(data: [ProductModel]) {
        self.allProducts = data
    }
    
    func setProdyctTypes(data: [ProductType]) {
        self.prodyctTypes = data
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.menuView.tableView.reloadData()
            self.menuView.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discontProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscounCollectionCell.identifier, for: indexPath) as? DiscounCollectionCell else { return UICollectionViewCell() }
        cell.configure(image: UIImage(named: discontProduct[indexPath.row]) ?? UIImage())
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: 112)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(model: allProducts[indexPath.row])
        presenter.loadImage(for: cell.productImage, imageName: allProducts[indexPath.row].icon)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let hedaer = tableView.dequeueReusableHeaderFooterView(withIdentifier: SelectCategoryCollectionViewCell.identifier) as? SelectCategoryCollectionViewCell else { return UITableViewHeaderFooterView() }
        hedaer.delegete = self
        hedaer.configure(prodyctTypes)
        return hedaer
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalDistance = scrollView.contentOffset.y
        if verticalDistance > 150 {
            menuView.showDiscontView(false)
        } else {
            menuView.showDiscontView(true)
        }
    }
}

//MARK: - SelectCategoryCollectionViewCellDelegete
extension MenuViewController: SelectCategoryCollectionViewCellDelegete {
    func didSelectCategiry(type: SelectionType) {
        let indexItem = allProducts.firstIndex(where: { $0.type == type }) ?? 0
        menuView.tableView.scrollToRow(at: IndexPath(row: indexItem, section: 0),
                                       at: .top,
                                       animated: true)
    }
}

//MARK: - NavBarConfigure
extension MenuViewController {
    private func configureNavBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = makeLeftBarButtonItems()
    }

    private func makeLeftBarButtonItems() -> UIBarButtonItem {
        let dropDownButtonItem = UIBarButtonItem(title: "Москва v",
                                                 image: nil,
                                                 primaryAction: nil,
                                                 menu: makeDropDownMenu())
        return dropDownButtonItem
    }
    
    private func makeDropDownMenu() -> UIMenu {
        let addAddress = UIAction(title: "Новый адрес",
                                  image: UIImage(systemName: "location.circle")) { _ in }
        
        let myAddress = UIAction(title: "Мои адреса",
                                 image: UIImage(systemName: "pin")) { _ in }
        
        return UIMenu(title: "", children: [addAddress, myAddress])
    }
}

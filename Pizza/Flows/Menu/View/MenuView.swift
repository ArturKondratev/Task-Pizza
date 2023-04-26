//
//  MenuView.swift
//  Pizza
//
//  Created by Артур Кондратьев on 03.04.2023.
//

import UIKit

class MenuView: UIView {
    //MARK: - Constraints
    var tbTopShowConstraint = NSLayoutConstraint()
    var tbTopHidenConstraint = NSLayoutConstraint()
    
    // MARK: - SubView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemGray6
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(DiscounCollectionCell.self, forCellWithReuseIdentifier: DiscounCollectionCell.identifier)
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset.left = 0
        tableView.separatorInset.right = 0
        tableView.backgroundColor = .systemGray6
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(SelectCategoryCollectionViewCell.self, forHeaderFooterViewReuseIdentifier: SelectCategoryCollectionViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    // MARK: - UI
    func setUI() {
        backgroundColor = .systemGray6
        self.addSubview(collectionView)
        self.addSubview(tableView)
        
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 112).isActive = true
        
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        tbTopShowConstraint = tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor)
        tbTopHidenConstraint = tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        tbTopShowConstraint.isActive = true
    }
    
    func showDiscontView(_ state: Bool) {
        if state {
            layoutIfNeeded()
            tbTopShowConstraint.isActive = true
            tbTopHidenConstraint.isActive = false

            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
            tbTopShowConstraint.isActive = false
            tbTopHidenConstraint.isActive = true

            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
}

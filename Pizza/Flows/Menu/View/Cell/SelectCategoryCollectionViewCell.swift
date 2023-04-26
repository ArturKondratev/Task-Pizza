//
//  Header.swift
//  Pizza
//
//  Created by Артур Кондратьев on 03.04.2023.
//

import UIKit

protocol SelectCategoryCollectionViewCellDelegete: AnyObject {
    func didSelectCategiry(type: SelectionType)
}

class SelectCategoryCollectionViewCell: UITableViewHeaderFooterView {
    //MARK: - Properis
    static let identifier = "SelectCategoryCollectionViewCell"
    weak var delegete: SelectCategoryCollectionViewCellDelegete?
    var productTyps = [ProductType]()
    var selectionType: SelectionType = .Pizza {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - SubViews
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 23
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(SelectCategoryCell.self, forCellWithReuseIdentifier: SelectCategoryCell.identifier)
        return collectionView
    }()
    
    //MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ productTyps: [ProductType]){
        self.productTyps = productTyps
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - SetUI
    func setUI() {
        backgroundColor = .systemGray6
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension SelectCategoryCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productTyps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.identifier, for: indexPath) as! SelectCategoryCell
        
        let state = selectionType == productTyps[indexPath.row].type
        cell.configure(name: productTyps[indexPath.row].name ,
                       isSelected: state)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionType = productTyps[indexPath.row].type
        delegete?.didSelectCategiry(type: selectionType)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SelectCategoryCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 50)
    }
}

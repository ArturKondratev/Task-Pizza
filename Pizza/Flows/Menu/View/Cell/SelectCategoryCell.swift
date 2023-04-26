//
//  SelectCategoryCell.swift
//  Pizza
//
//  Created by Артур Кондратьев on 03.04.2023.
//

import UIKit


class SelectCategoryCell: UICollectionViewCell {
    //MARK: - Properis
    static let identifier = "SelectCategoryCell"
    
    //MARK: - SubViews
    lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.borderColor = UIColor.brandPink.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = UIConstants.categoryButtonHeight / 2
        button.setTitleColor (.brandPink, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Private constants
    private enum UIConstants {
        static let categoryButtonHeight: CGFloat = 32
        static let categoryButtonWidth: CGFloat = 88
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String ,isSelected: Bool) {
        categoryButton.setTitle(name, for: .normal)
        if isSelected {
            categoryButton.backgroundColor = .brandPink
            categoryButton.setTitleColor (.red, for: .normal)
        } else {
            categoryButton.backgroundColor = .clear
            categoryButton.setTitleColor (.brandPink, for: .normal)
        }
    }
    
    //MARK: - SetUI
    func setUI() {
        backgroundColor = .systemGray6
        addSubview(categoryButton)
        NSLayoutConstraint.activate([
            categoryButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryButton.widthAnchor.constraint(equalToConstant: UIConstants.categoryButtonWidth),
            categoryButton.heightAnchor.constraint(equalToConstant: UIConstants.categoryButtonHeight),
        ])
    }
}

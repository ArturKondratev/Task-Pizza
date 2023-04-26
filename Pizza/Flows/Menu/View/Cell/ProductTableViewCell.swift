//
//  ProductTableViewCell.swift
//  Pizza
//
//  Created by Артур Кондратьев on 03.04.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    //MARK: - Properis
    static let identifier = "ProductTableViewCell"
    
    //MARK: - SubViews
    lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = UIConstants.productImageSize / 2
        return image
    }()
    
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.productNameLabelSize)
        return label
    }()
    
    lazy var productDescriptionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray3
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: UIConstants.productDescriptionsLabelSize)
        return label
    }()
    
    lazy var costButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.setTitleColor (.red, for: .normal)
        button.setTitle("от 345 р", for: .normal)
        return button
    }()
    
    // MARK: - Private constants
    private enum UIConstants {
        static let productNameLabelSize: CGFloat = 20
        static let productDescriptionsLabelSize: CGFloat = 16
        static let productImageSize: CGFloat = 132
        static let costButtonHeight: CGFloat = 32
        static let costButtonWidth: CGFloat = 87
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
        productNameLabel.text = nil
        productDescriptionsLabel.text = nil
    }
    
    func configure(model: ProductModel ) {
        productNameLabel.text = model.name
        productDescriptionsLabel.text = model.description
    }
    
    //MARK: - SetUI
    func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(productImage)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productDescriptionsLabel)
        contentView.addSubview(costButton)
        NSLayoutConstraint.activate([
            productImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            productImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            productImage.heightAnchor.constraint(equalToConstant: UIConstants.productImageSize),
            productImage.widthAnchor.constraint(equalToConstant: UIConstants.productImageSize),
            
            productNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            productNameLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 32),
            productNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            
            productDescriptionsLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            productDescriptionsLabel.leftAnchor.constraint(equalTo: productNameLabel.leftAnchor),
            productDescriptionsLabel.rightAnchor.constraint(equalTo: productNameLabel.rightAnchor),
            
            costButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            costButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            costButton.widthAnchor.constraint(equalToConstant: UIConstants.costButtonWidth),
            costButton.heightAnchor.constraint(equalToConstant: UIConstants.costButtonHeight)
        ])
    }
}

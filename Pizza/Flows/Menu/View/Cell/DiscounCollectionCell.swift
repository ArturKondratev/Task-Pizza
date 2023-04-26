//
//  DiscounCollectionCell.swift
//  Pizza
//
//  Created by Артур Кондратьев on 04.04.2023.
//

import UIKit

class DiscounCollectionCell: UICollectionViewCell {
    //MARK: - Properis
    static let identifier = "DiscounCollectionCell"
    
    //MARK: - SubViews
    lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - Private constants
    private enum UIConstants {
        static let categoryButtonHeight: CGFloat = 112
        static let categoryButtonWidth: CGFloat = 300
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage) {
        self.mainImage.image = image
    }
    
    //MARK: - SetUI
    func setUI() {
        backgroundColor = .systemGray6
        addSubview(mainImage)
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: topAnchor),
            mainImage.leftAnchor.constraint(equalTo: leftAnchor),
            mainImage.rightAnchor.constraint(equalTo: rightAnchor),
            mainImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: UIConstants.categoryButtonWidth),
            mainImage.heightAnchor.constraint(equalToConstant: UIConstants.categoryButtonHeight),
        ])
    }
}

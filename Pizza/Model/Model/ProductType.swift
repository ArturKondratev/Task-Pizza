//
//  ProductModel.swift
//  Pizza
//
//  Created by Артур Кондратьев on 04.04.2023.
//

import Foundation

struct ProductType {
    let name: String
    let type: SelectionType
}

enum SelectionType: String{
    case Pizza = "Pizza"
    case Kombo = "Kombo"
    case Drinks = "Drinks"
    case Dessert = "Dessert"
}

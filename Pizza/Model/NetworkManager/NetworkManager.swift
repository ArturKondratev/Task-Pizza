//
//  ApiManager.swift
//  Pizza
//
//  Created by Артур Кондратьев on 05.04.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

protocol NetworkManagerProtocol {
    func getData(completion: @escaping([ProductModel]?) -> Void )
    func getImage(picName: String, completion: @escaping (UIImage) -> Void)
    func getDiscontProduct() -> [String]
    func getProductType() -> [ProductType]
}

class NetworkManager: NetworkManagerProtocol {
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    private func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func getData(completion: @escaping([ProductModel]?) -> Void ) {
        var allProducts = [ProductModel]()
        
        Firestore.firestore().collection("Data").getDocuments { doc, error in
            if error != nil {completion(nil); return }
            
            guard let docs = doc?.documents else { return }
            for doc in docs {
                let data = doc.data()
                let name = data["name"] as! String
                let description = data["description"] as! String
                let icon = data["icon"] as! String
                let type = SelectionType(rawValue: data["type"] as! String) ?? .Pizza
                allProducts.append(ProductModel(name: name,
                                                description: description,
                                                icon: icon,
                                                type: type))
            }
            completion(allProducts)
        }
    }
    
    func getImage(picName: String, completion: @escaping (UIImage) -> Void) {
        if let cachedImage = imageCache.object(forKey: picName as NSString) {
            completion(cachedImage)
        } else {
            let storage = Storage.storage()
            let reference = storage.reference()
            let pathRef = reference.child("DiscontPIctures")
            let fileRef = pathRef.child(picName + ".jpeg")
            let image: UIImage = UIImage(systemName: "star")!
            
            fileRef.getData(maxSize: .max) { data, error in
                guard error == nil else { completion(image); return }
                
                if let data = data, let icon = UIImage(data: data) {
                    self.imageCache.setObject(icon, forKey: picName as NSString)
                    completion(icon)
                }
            }
        }
    }
    
    func getDiscontProduct() -> [String] {
        return ["discont", "discont", "discont", "discont", "discont"]
    }
    
    func getProductType() -> [ProductType] {
        return [
            ProductType(name: "Пицца", type: .Pizza),
            ProductType(name: "Комбо", type: .Kombo),
            ProductType(name: "Десерты", type: .Dessert),
            ProductType(name: "Напитки", type: .Drinks)
        ]
    }
}

//
//  DataRepository.swift
//  ZivameTask
//
//  Created by Sandeepan Swain on 23/09/21.
//

import Foundation
import CoreData

protocol DataRepository {
    func create(store: Products)
    func getAll() -> [Products]?
    func delete() -> Bool
}

struct ProductDataRepository: DataRepository {
    func create(store: Products) {
        let storeProduct = Order(context: PersistentStorage.shared.context)
        if let storeName = store.name,let storePrice = store.price,let storeImage = store.image_url {
            storeProduct.orderName = storeName
            storeProduct.orderImage = storeImage
            storeProduct.orderPrice = String(storePrice)
        }

        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Products]? {
        debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Order.self)

        var stores : [Products] = []

        result?.forEach({ (productsOrder) in
            if let ordername = productsOrder.orderName, let orderPrice = productsOrder.orderPrice, let orderImage = productsOrder.orderImage {
                let product = Products(name: productsOrder.orderName, price: productsOrder.orderPrice, image_url: productsOrder.orderImage, rating: 0)
                stores.append(product)
            }
        })

        return stores
    }
    
    func delete() -> Bool {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = PersistentStorage.shared.context
            let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Order"))
            do {
                try managedContext.execute(DelAllReqVar)
                return true
            }
            catch {
                print(error)
                return false
            }
    }
    
}

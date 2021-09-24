//
//  StoreManager.swift
//  ZivameTask
//
//  Created by Sandeepan Swain on 23/09/21.
//

import Foundation

struct StoreManager {
    private let dataRepository = ProductDataRepository()

    func storeProduct(prod: Products) {
        dataRepository.create(store: prod)
    }

    func getAll() -> [Products]? {
        return dataRepository.getAll()
    }
    
    func delete() -> Bool {
        return dataRepository.delete()
    }
}

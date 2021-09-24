//
//  ProductViewModel.swift
//  ZivameTask
//
//  Created by Sandeepan Swain on 21/09/21.
//

import Foundation

class ProductViewModel {
    
    private let productData: [Products]?
    
    //Dependency Injection
    init(productData: [Products]) {
         self.productData = productData
    }
    
//    func sortedProducts() -> [Products]? {
//
//        guard var sortedNews = self.productData else { return nil}
//
//        var sorted = sortedNews.sorted {
//            var isSorted = false
//            if let first = Int($0.price!) , let second = Int($1.price!) {
//                isSorted = first < second
//            }
//            return isSorted
//        }
//      //  print(sort)
//        return sorted
//    }
    
    func sortDataForGreaterValue() -> [Products]? {
        guard var sortedProduct = self.productData else { return nil}
        var sortedArray:[Products] = []
        var sorted = sortedProduct.filter {
            var isSorted = false
            if let price = Int($0.price!),price > 1000 {
                isSorted = true
                sortedArray.append($0)
            }
            return isSorted
        }
        return sortedArray
    }
    
    func sortDataForLessValue() -> [Products]? {
        guard var sortedProduct = self.productData else { return nil}
        var sortedArray:[Products] = []
        var sorted = sortedProduct.filter {
            var isSorted = false
            if let price = Int($0.price!),price < 1000 {
                isSorted = true
                sortedArray.append($0)
            }
            return isSorted
        }
        return sortedArray
    }
    
   
}

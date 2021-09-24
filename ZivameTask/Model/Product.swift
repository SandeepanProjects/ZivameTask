//
//  Product.swift
//  ZivameTask
//
//  Created by Sandeepan Swain on 21/09/21.
//

import Foundation


struct Product: Codable {
    var products: [Products]?
//    enum CodingKeys: String, CodingKey {
//
//        case products = "products"
//    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        products = try values.decodeIfPresent([Products].self, forKey: .products)
//    }
}

struct Products: Codable {
    let name : String?
    let price : String?
    let image_url : String?
    let rating : Int?

//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case price = "price"
//        case image_url = "image_url"
//        case rating = "rating"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        price = try values.decodeIfPresent(String.self, forKey: .price)
//        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
//        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
//    }

}


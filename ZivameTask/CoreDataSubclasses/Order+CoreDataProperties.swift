//
//  Order+CoreDataProperties.swift
//  ZivameTask
//
//  Created by Sandeepan Swain on 23/09/21.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var orderImage: String?
    @NSManaged public var orderName: String?
    @NSManaged public var orderPrice: String?

}

extension Order : Identifiable {

}

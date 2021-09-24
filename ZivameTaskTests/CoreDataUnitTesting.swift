//
//  CoreDataUnitTesting.swift
//  ZivameTaskTests
//
//  Created by Sandeepan Swain on 24/09/21.
//

import XCTest
import CoreData
@testable import ZivameTask

var manager: PersistentStorage?

class CoreDataUnitTesting: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        manager = PersistentStorage.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        manager = nil
    }
      
      // MARK: Our test cases
      
      /*this test case test for the proper initialization of CoreDataManager class :)*/
        func test_init_coreDataManager(){
          
          /*Asserts that an expression is not nil.
           Generates a failure when expression == nil.*/
          XCTAssertNotNil( manager )
        }
        
        /*This test case inserts a person record*/
        func test_create_product() {
          
         let dataRepository = ProductDataRepository()

          let product1 = Products(name: "Samsung", price: "30000", image_url: "https://images-eu.ssl-images-amazon.com/images/I/41DZ309iN9L._AC_US160_.jpg", rating: 4)
          let product2 = Products(name: "Moto", price: "31000", image_url: "https://images-eu.ssl-images-amazon.com/images/I/41INpKtZV-L._AC_US160_.jpg", rating: 3)
            
          /*Asserts that an expression is not nil.
           Generates a failure when expression == nil.*/
          XCTAssertNotNil( product1 )
          
          let createProduct1 = dataRepository.create(store: product1)
          
          /*Asserts that an expression is not nil.
           Generates a failure when expression == nil.*/
          XCTAssertNotNil( createProduct1 )
          
          let createProduct2 = dataRepository.create(store: product2)
          
          /*Asserts that an expression is not nil.
           Generates a failure when expression == nil.*/
          XCTAssertNotNil( createProduct2 )
          
        }
}

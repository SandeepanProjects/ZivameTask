//
//  ResourceUnitTests.swift
//  ZivameTaskTests
//
//  Created by Sandeepan Swain on 24/09/21.
//

import XCTest
@testable import ZivameTask

class ResourceUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testcheckForSuccesfulRequest() throws {
        let expectation = self.expectation(description: "SUCCESS_RESPONSE")
        
        Networking.fetchProducts { (result) in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func testCheckForSortedProducts() throws {
        
    }
    
    
}

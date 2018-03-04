//
//  DataServiceTests.swift
//  CVTests
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import XCTest
@testable import CV

class DataServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDataServiceGetRootFromValidJSON_ReturnRootObjectNonNil() {
     
        let json = TestJSON.validJSONWithThreeAreasOneSectionEachOneRowEach
        let root = try? DataService.shared.getRoot(json: json)
        
        XCTAssertNotNil(root)
        
    }
    
}

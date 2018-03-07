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
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testCreateDataServiceWithBundleURL_ReturnNonNilObject() {
        
        let bundle = Bundle(for: DataServiceTests.classForCoder())
        let dataService = DataService(baseURL: bundle.bundleURL)
        XCTAssertNotNil(dataService)
        
    }
    
    func testGetAreasWithCorrectRESTName_ReturnInCompletionNonEmptyAreasAndNilError() {
        
        let expectation = XCTestExpectation(description: "Get Areas from json file in Test Bundle")
        
        let bundle = Bundle(for: DataServiceTests.classForCoder())
        let dataService = DataService(baseURL: bundle.bundleURL)
        dataService.areas(with: "test.json", sessionConfiguration: URLSessionConfiguration.ephemeral) { (areas, error) in

            XCTAssertNotNil(areas)
            XCTAssertTrue(areas.count > 0)
            XCTAssertNil(error)
            expectation.fulfill()

        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testGetAreasWithWrongRESTName_ReturnInCompletionEmptyAreasAndNonNilError() {
        
        let expectation = XCTestExpectation(description: "Get Areas from json file in Test Bundle")
        
        let bundle = Bundle(for: DataServiceTests.classForCoder())
        let dataService = DataService(baseURL: bundle.bundleURL)
        dataService.areas(with: "wrong.json", sessionConfiguration: URLSessionConfiguration.ephemeral) { (areas, error) in
            
            XCTAssertEqual(areas.count, 0)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? DataService.Error, DataService.Error.missingJSON)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
}

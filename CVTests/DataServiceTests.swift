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
    
    //  MARK: - Get JSON
    
    func testGetJSONFromTestBundle() {
        
        let json = try? DataService.shared.getJSON(with: "test", bundle: Bundle(for: DataServiceTests.classForCoder()))
        XCTAssertNotNil(json)
    }
    
    func testGetJSONWithWrongName_ThrowMissingJSONError() {
        
        XCTAssertThrowsError(try DataService.shared.getJSON(with: "data", bundle: Bundle(for: DataServiceTests.classForCoder()))) { (error) in
            XCTAssertEqual(error as? DataService.Error, DataService.Error.missingJSON)
        }
    }
    
    //  MARK: - Decoding

    func testDataServiceGetRootFromValidJSON_ReturnRootObjectNonNil() {
     
        let json = TestJSON.validJSONWithThreeAreasOneSectionEachOneRowEach
        let root = try? DataService.shared.getRoot(json: json)
        
        XCTAssertNotNil(root)
        
    }
    
    func testDataServiceGetRootFromValidJSON_ReturnThreeAreasOneSectionEachOneRowEach_WithExpectedNames() {
        
        let json = TestJSON.validJSONWithThreeAreasOneSectionEachOneRowEach
        let root = try? DataService.shared.getRoot(json: json)
        let areas = root?.areas
        
        XCTAssertEqual(areas?.count, 3)
        //  names
        XCTAssertEqual(areas?[0].name, "me")
        XCTAssertEqual(areas?[1].name, "experience")
        XCTAssertEqual(areas?[2].name, "settings")
        //  number of sections
        XCTAssertEqual(areas?[0].sections.count, 1)
        XCTAssertEqual(areas?[1].sections.count, 1)
        XCTAssertEqual(areas?[1].sections.count, 1)
        //  section names
        XCTAssertEqual(areas?[0].sections[0].name, "Personal Details")
        XCTAssertEqual(areas?[1].sections[0].name, "iOS Developer")
        XCTAssertEqual(areas?[2].sections[0].name, "Info")
        //  number of rows
        XCTAssertEqual(areas?[0].sections[0].rows.count, 1)
        XCTAssertEqual(areas?[1].sections[0].rows.count, 1)
        XCTAssertEqual(areas?[2].sections[0].rows.count, 1)
        
    }

    func testDataServiceGetRootFromValidJSON_ReturnCorrectRowTypesAndTitleAndDetails() {
        
        let json = TestJSON.validJSONWithThreeAreasOneSectionEachOneRowEach
        let root = try? DataService.shared.getRoot(json: json)
        let areas = root?.areas
        
        //  Types
        XCTAssertEqual(areas?[0].sections[0].rows[0].type, RowType.image)
        XCTAssertEqual(areas?[1].sections[0].rows[0].type, RowType.job)
        XCTAssertEqual(areas?[2].sections[0].rows[0].type, RowType.description)
        //  Titles
        XCTAssertEqual(areas?[0].sections[0].rows[0].title, "")
        XCTAssertEqual(areas?[1].sections[0].rows[0].title, "company")
        XCTAssertEqual(areas?[2].sections[0].rows[0].title, "app version")
        //  Details
        XCTAssertEqual(areas?[0].sections[0].rows[0].details, "profile.png")
        XCTAssertEqual(areas?[1].sections[0].rows[0].details, "TheFakeCompany Limited")
        XCTAssertEqual(areas?[2].sections[0].rows[0].details, "$(app_version)")

    }
    
    func testDataServiceGetRootFromValidButWrongJSON_ReturnNilRootObject() {
        
        let json = TestJSON.validJSONButWrong
        let root = try? DataService.shared.getRoot(json: json)
        
        XCTAssertNil(root)
        
    }
    
}

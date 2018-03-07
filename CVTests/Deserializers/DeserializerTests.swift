//
//  DeserializerTests.swift
//  CVTests
//
//  Created by Paolo Carollo on 07/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import XCTest
@testable import CV

class DeserializerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {

        super.tearDown()
    }

    func testDeserializeAreas_FromValidJSON_ReturnListOfAreasWithExpectedValues() {

        let data = TestJSON.validJSONWithThreeAreasOneSectionEachOneRowEach.data(using: .utf8)
        let root: Root = try! Deserializer.shared.deserialize(data: data!)
        
        XCTAssertEqual(root.areas.count, 3)
        
        
    }
    
    func testDeserializeArea_FromValidJSON_ReturnArea() {

        let data = TestJSON.validAreaJSON.data(using: .utf8)
        let area: Area = try! Deserializer.shared.deserialize(data: data!)
        
        XCTAssertEqual(area.name, "me")
        XCTAssertEqual(area.sections.count, 1)

    }
    
    func testDeserializeSection_FromValidJSON_ReturnSectionWithExpectedValues() {

        let data = TestJSON.validSectionJSON.data(using: .utf8)
        let section: Section = try! Deserializer.shared.deserialize(data: data!)
        
        XCTAssertEqual(section.name, "Personal Details")
        XCTAssertEqual(section.rows.count, 1)
        
    }
    
    func testDeserializeRow_FromValidJSON_ReturnRowWithExpectedValues() {
        
        let data = TestJSON.validRowJSON.data(using: .utf8)
        let row: Row = try! Deserializer.shared.deserialize(data: data!)
        
        XCTAssertEqual(row.type, .image)
        XCTAssertEqual(row.title, "")
        XCTAssertEqual(row.details, "profile.png")
        
    }
    
    func testDeserializeUnits_FromValidJSON_ReturnListOfUnitsWithExpectedValues() {
        
    }

    
}

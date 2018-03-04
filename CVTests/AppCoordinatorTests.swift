//
//  AppCoordinatorTests.swift
//  CVTests
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import XCTest
@testable import CV

class AppCoordinatorTests: XCTestCase {
    
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()

        self.window = UIWindow()
    }
    
    override func tearDown() {

        super.tearDown()
    }

    func testCreateAppCoordinator_ReturnNonNilObject() {
        
        let appCoordinator = AppCoordinator(in: window)
        XCTAssertNotNil(appCoordinator)
        
    }
    
    func testStartAppCoordinator_SetTabBarControllerAsRootViewController() {
        
        let appCoordinator = AppCoordinator(in: window)
        let tabBarController = appCoordinator.tabBarController
        
        XCTAssertNotNil(tabBarController)
        XCTAssertNil(window.rootViewController)
        
        appCoordinator.start()
        XCTAssertEqual(window.rootViewController, tabBarController)
        
    }

    
}

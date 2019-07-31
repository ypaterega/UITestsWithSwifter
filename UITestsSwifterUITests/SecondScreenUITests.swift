//
//  SecondScreenUITests.swift
//  UITestsSwifterUITests
//
//  Created by Iurii Paterega on 30/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import Foundation
import XCTest
import Swifter
@testable import UITestsSwifter

class SecondScreenUITests: XCTestCase {

    let stubs = HttpStubService()

    var app : XCUIApplication {
        return XCUIApplication()
    }

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        stubs.setUp()

        let app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        stubs.tearDown()
        super.tearDown()
    }

    //Initial stubs in HttpStubService
    func testLoadSecondScreen() {

        let tabBarQuery = app.tabBars
        tabBarQuery.buttons["SecondScreenViewController.tabBarItem"].tap()

        let tableViewQuery = app.tables.matching(identifier: "SecondScreenCoordinator.tableView")
        let cell = app.tables.cells.element(matching: .cell, identifier: "CustomTableViewCell_1")
        XCTAssert(cell.waitForExistence(timeout: 2), "Cell is not excisted")

        let cellsCount = tableViewQuery.cells.count
        XCTAssertEqual(cellsCount, 10, "Cells count should be equal to json data")
    }
    
    //Started with initial stubs in HttpStubService then change initial stub to another
    func testReloadLoadSecondScreen() {
        
        let tabBarQuery = app.tabBars
        tabBarQuery.buttons["SecondScreenViewController.tabBarItem"].tap()
        
        let tableViewQuery = app.tables.matching(identifier: "SecondScreenCoordinator.tableView")
        let cell = app.tables.cells.element(matching: .cell, identifier: "CustomTableViewCell_0")
        XCTAssert(cell.waitForExistence(timeout: 2), "Cell is not excisted")
        
        let cellsCount = tableViewQuery.cells.count
        XCTAssertEqual(cellsCount, 10, "Cells count should be equal to json data")
        
        let firstControllerTabBarItem = tabBarQuery.buttons["FirstScreenViewController.tabBarItem"]
        firstControllerTabBarItem.tap()
        
        XCTAssert(app.textFields["FirstScreenViewController.textField"].exists)
 
        stubs.setupStub(url: "/new", filename: "new_small")
        
        tabBarQuery.buttons["SecondScreenViewController.tabBarItem"].tap()
        
        let cellAfterReload = app.tables.cells.element(matching: .cell, identifier: "CustomTableViewCell_0")
        XCTAssert(cellAfterReload.waitForExistence(timeout: 2), "Cell is not excisted")
        
        let cellsCountAfterReload = tableViewQuery.cells.count
        XCTAssertEqual(cellsCountAfterReload, 3, "Cells count should be equal to json data")
        
    }
    
}

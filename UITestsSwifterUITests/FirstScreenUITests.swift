//
//  FirstScreenUITests.swift
//  UITestsSwifterUITests
//
//  Created by Iurii Paterega on 26/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import Foundation
import XCTest
import Swifter
@testable import UITestsSwifter

class FirstScreenUITests: XCTestCase {

    let stubs = HttpStubService()

    var app : XCUIApplication {
        return XCUIApplication()
    }

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        stubs.setUp()

        let app = XCUIApplication()
        //for active compilation condition
        //app.launchArguments = ["TEST"]
        app.launch()
    }

    override func tearDown() {
        stubs.tearDown()
        super.tearDown()
    }

    //Stubs are added during tests
    func testSearchForBook() {

        let searchTextField = app.textFields["FirstScreenViewController.textField"]
        searchTextField.tap()
        let text =  "MongoDB"
        searchTextField.typeText(text)

        stubs.setupStub(url: "/search/\(text)", filename: "search")

        let searchButton = app.buttons["FirstScreenViewController.searchButton"]
        searchButton.tap()

        let textLabel = app.staticTexts.element(matching: .any, identifier: "FirstScreenViewController.bookTitleLabel").label
        let image = app.images["FirstScreenViewController.bookImageView"]

        XCTAssertEqual(textLabel, "Practical MongoDB", "label text should be equal to mocked in json")
        XCTAssert(image.exists, "image should exist")
    }
}


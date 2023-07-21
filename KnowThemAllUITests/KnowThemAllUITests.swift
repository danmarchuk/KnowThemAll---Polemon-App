//
//  KnowThemAllUITests.swift
//  KnowThemAllUITests
//
//  Created by Данік on 08/07/2023.
//

import XCTest


class KnowThemAllUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testPokeDetailViewModel() {
        let mainScreen = app.collectionViews.element(boundBy: 0)
        
        let cellIndices = [1,2,3,4,5,6,7,8]
        for index in cellIndices {
            mainScreen.swipeDown()
            let cell = mainScreen.cells["Cell_\(index)"]
            XCTAssertTrue(cell.waitForExistence(timeout: 5.0))
            
            cell.tap()
            XCTAssert(app.buttons["BackArrowButton"].exists)
            XCTAssert(app.staticTexts["PokeNameLabel"].exists)
            XCTAssert(app.images["PokeImage"].exists)
            
            app.buttons["BackArrowButton"].tap()
            XCTAssertTrue(mainScreen.exists)
            
        }
    }
    
    func testCollectionViewScrolling() {
        let mainScreen = app.collectionViews.element(boundBy: 0)

        let cell = mainScreen.cells["Cell_10"]
        while !cell.isVisible {
            mainScreen.swipeUp()
        }
        XCTAssertTrue(cell.waitForExistence(timeout: 5.0))
    }
    
    func testCollectionViewScrollingToCell5() {
        let mainScreen = app.collectionViews.element(boundBy: 0)

        let cell = mainScreen.cells["Cell_5"]
        while !cell.isVisible {
            mainScreen.swipeUp()
        }
        XCTAssertTrue(cell.waitForExistence(timeout: 5.0))
    }

    func testCollectionViewScrollingToCell15() {
        let mainScreen = app.collectionViews.element(boundBy: 0)

        let cell = mainScreen.cells["Cell_15"]
        while !cell.isVisible {
            mainScreen.swipeUp()
        }
        XCTAssertTrue(cell.waitForExistence(timeout: 5.0))
    }

    func testCollectionViewScrollingToCell20() {
        let mainScreen = app.collectionViews.element(boundBy: 0)

        let cell = mainScreen.cells["Cell_20"]
        while !cell.isVisible {
            mainScreen.swipeUp()
        }
        XCTAssertTrue(cell.waitForExistence(timeout: 5.0))
    }

    func testCollectionViewScrollingToCell25() {
        let mainScreen = app.collectionViews.element(boundBy: 0)

        let cell = mainScreen.cells["Cell_25"]
        while !cell.isVisible {
            mainScreen.swipeUp()
        }
        XCTAssertTrue(cell.waitForExistence(timeout: 5.0))
    }

    func testCollectionViewScrollingToCell30() {
        let mainScreen = app.collectionViews.element(boundBy: 0)

        let cell = mainScreen.cells["Cell_30"]
        while !cell.isVisible {
            mainScreen.swipeUp()
        }
        XCTAssertTrue(cell.waitForExistence(timeout: 5.0))
    }


}

extension XCUIElement {
    var isVisible: Bool {
        guard exists, !frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }
}

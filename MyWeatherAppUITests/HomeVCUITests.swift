//
//  HomeVCUITests.swift
//  MyWeatherAppUITests
//
//  Created by madhu kiran on 07/01/21.
//

import XCTest

class HomeVCUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.navigationBars["Home"].buttons["Add"].tap()
        app.navigationBars["Search for location"].searchFields["Type place name here"].tap()
        app.otherElements["Hyderabad, Hyderabad"].tap()
    }
    
    
   
    func testGetNumber()throws {
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["80.49952338449657"]/*[[".cells.staticTexts[\"80.49952338449657\"]",".staticTexts[\"80.49952338449657\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.tables.staticTexts["Hyderabad"]
        let element = app.collectionViews.cells.otherElements.containing(.staticText, identifier:"2021-01-07 18:00:00").element
        element/*@START_MENU_TOKEN@*/.press(forDuration: 2.2);/*[[".tap()",".press(forDuration: 2.2);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        element.swipeLeft()
    }

}

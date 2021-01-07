//
//  SettingsVCTests.swift
//  MyWeatherAppTests
//
//  Created by madhu kiran on 07/01/21.
//
import XCTest
@testable import MyWeatherApp

class SettingsVCTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testNumberOfRows(){

        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyboard.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
//
//        var  countRow:Int =  vc.tableView.numberOfRows(inSection: 0)
//              XCTAssert(countRow == 4)
//        print(vc.classForCoder )
//        print(vc.tableView.numberOfRows(inSection: 0))
    }

}

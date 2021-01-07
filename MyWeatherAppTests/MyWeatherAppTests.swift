//
//  MyWeatherAppTests.swift
//  MyWeatherAppTests
//
//  Created by madhu kiran on 05/01/21.
//
import UIKit
import XCTest
@testable import MyWeatherApp

class MyWeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        test_WebServiceManagerExist()
        test_DataManagerExist()
        
    }
    func test_DataManagerExist(){
        let dataManager = DataManager.sharedInstance
        XCTAssertNotNil(dataManager)
    }
    
    func test_WebServiceManagerExist(){
        let webServicemanager = APIManager.sharedInstance
        XCTAssertNotNil(webServicemanager)
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

    
}

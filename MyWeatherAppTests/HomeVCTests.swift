//
//  HomeVCTests.swift
//  MyWeatherAppTests
//
//  Created by madhu kiran on 07/01/21.
//

import XCTest
@testable import MyWeatherApp

class HomeVCTests: XCTestCase {

    var storyboard: UIStoryboard!
    var homeVC: UIViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeVC = storyboard.instantiateViewController(identifier: "HomeViewController")
        homeVC.loadViewIfNeeded()
        homeVC.viewDidLoad()
        
        //XCTAssertTrue(homeVC.tabBarController!.tabBarItem.title == "Home")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        homeVC = nil
    }

    func testBarbuttonItemHomeVC() throws{
        //check if rightbarbutton present
        if let rightbarbutton = homeVC.navigationItem.rightBarButtonItem{
            XCTAssertTrue(rightbarbutton.action?.description == "addLocation")
            XCTAssertTrue(4 == UIBarButtonItem.SystemItem.add.rawValue)//barbutton raw value is 4
        }else{
            XCTAssertTrue(false)
        }
    }
    
    func testTableViewHomeVC()throws{
                
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            //testInsert()
            
        }
    }
}

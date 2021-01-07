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
    var homeVC: HomeViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeVC = storyboard.instantiateViewController(identifier: "HomeViewController") as HomeViewController
        homeVC.loadViewIfNeeded()
        homeVC.viewDidLoad()
        homeVC.viewDidAppear(true)
        XCTAssertTrue(homeVC.navigationItem.title == "Home")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        //homeVC = nil
    }

    func testBarbuttonItemHomeVC() throws{
        XCTAssertTrue(homeVC.navigationItem.title == "Home")
         
        //check if rightbarbutton present
        if let rightbarbutton = homeVC.navigationItem.rightBarButtonItem{
            XCTAssertTrue(rightbarbutton.action?.description == "addLocation")
            XCTAssertTrue(4 == UIBarButtonItem.SystemItem.add.rawValue)//barbutton raw value is 4
        }else{
            XCTAssertTrue(false)
        }
    }
    
    func testTableViewHomeVC()throws{
           
        XCTAssertTrue(homeVC.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(homeVC.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(homeVC  is HomeViewController)

        
//        XCTAssertNotNil(homeVC.)
//        let tableView = try XCTUnwrap(homeVC.t, "The firstNameTextField is not connected to an IBOutlet")
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

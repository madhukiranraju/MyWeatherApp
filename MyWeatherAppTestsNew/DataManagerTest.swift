//
//  DataManagerTest.swift
//  MyWeatherAppTests
//
//  Created by madhu kiran on 06/01/21.
//

import XCTest
@testable import MyWeatherApp

class DataManagerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        test_DataManagerExist()
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
            //testInsert()
            
        }
    }
    func test_DataManagerExist(){
        let dataManager = DataManager.sharedInstance
        XCTAssertNotNil(dataManager)
        testInsert()
    }
    
    func testInsert(){
        let dataManager = DataManager.sharedInstance
        
//        self.measure {
            for _ in 0...1000{
                let latitude = "26.8191"
                let longitude = "80.4995"
                let uuid = UUID().uuidString
                let place = "Kurnool"
                
                let fav = Place(placeName: place, latitude: latitude, longitude: longitude, uuid: uuid)
                try! dataManager.insertFavPlace(item: fav)
            }
            testBatchDelete()
//        }
    }
    func testBatchDelete(){
        DataManager.sharedInstance.removeAllFavorites()
    }
    
    
    
}

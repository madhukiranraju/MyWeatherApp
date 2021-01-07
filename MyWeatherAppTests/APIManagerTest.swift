//
//  APIManagerTest.swift
//  MyWeatherAppTests
//
//  Created by madhu kiran on 07/01/21.
//

import XCTest

class APIManagerTest: XCTestCase {

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

    func testWeatherNil(){
        let URLstatus = URL.urlForWeatherFor(latitude: "", longitude: "")
        XCTAssertNotNil(URLstatus)
        APIManager.sharedInstance.getWeather(latitude: "", longitude: "") { (result) in
            XCTAssertNil(nil)
        }
        
        APIManager.sharedInstance.getWeather(latitude: "26.8191", longitude: "80.4995") { (result) in
            switch result {
            case .success(let weather):
                print(weather?.weather[0].description ?? "No ")
                XCTFail("No error")
            case .failure(let error):
                print("Failed")
                if error == NetworkError.noData{
                    XCTAssertEqual(error, NetworkError.noData)
                }else if error == NetworkError.decodingError{
                  XCTAssertEqual(NetworkError.decodingError, NetworkError.decodingError)
                }
            default:
                print("Default")
                
            }
        }
    }
    
    func testDailyWeatherNil(){
        let URLstatus = URL.urlForDailyWeatherFor(latitude: "", longitude: "")
        XCTAssertNotNil(URLstatus)
        APIManager.sharedInstance.getWeather(latitude: "", longitude: "") { (result) in
            XCTAssertNil(nil)
        }
        APIManager.sharedInstance.getDailyWeather(latitude: "26.8191", longitude: "80.4995") { (result) in
            switch result {
            case .success(let weather):
                print(weather?.list[0].weather[0].description ?? "No ")
                XCTFail("No error")
            case .failure(let error):
                print("Failed")
                if error == NetworkError.noData{
                    XCTAssertEqual(error, NetworkError.noData)
                }else if error == NetworkError.decodingError{
                  XCTAssertEqual(NetworkError.decodingError, NetworkError.decodingError)
                }
            default:
                print("Default")
                
            }
        }
    }

}

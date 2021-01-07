//
//  APIManagerTest.swift
//  MyWeatherAppTests
//
//  Created by madhu kiran on 07/01/21.
//

import XCTest
@testable import MyWeatherApp

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
        
        let expectation = self.expectation(description: " Web Service Response Expectation")
        
        APIManager.sharedInstance.getWeather(latitude: "26.8191", longitude: "80.4995") { (result) in
            
            switch result {
            case .success(let weather):
                print(weather?.weather[0].description ?? "No ")
//                XCTAssertEqual(type(of: weather!) , MyWeatherApp.WeatherResponse)//("No error")
                expectation.fulfill()
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
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testDailyWeatherNil(){
        let URLstatus = URL.urlForDailyWeatherFor(latitude: "", longitude: "")
        XCTAssertNotNil(URLstatus)
        APIManager.sharedInstance.getWeather(latitude: "", longitude: "") { (result) in
            XCTAssertNil(nil)
        }
        
        let expectation = self.expectation(description: " Web Service Response Expectation")

        APIManager.sharedInstance.getDailyWeather(latitude: "26.8191", longitude: "80.4995") { (result) in
            switch result {
            case .success(let weather):
                print(weather?.list[0].weather[0].description ?? "No ")
//                XCTAssertEqual(type(of: weather?.list[0]) , WeatherResponse.self)//("No error")
                expectation.fulfill()
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
        self.wait(for: [expectation], timeout: 5)

    }

}

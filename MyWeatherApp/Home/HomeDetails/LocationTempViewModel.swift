//
//  LocationTempViewModel.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import Foundation

class LocationTempViewModel{
    
    static let sharedInstance = LocationTempViewModel()
    private init(){}
    
    func getLocationTempFromAPI(latitude : String, longitude : String, completion:@escaping(WeatherResponse?)->Void){
        APIManager.sharedInstance.getWeather(latitude: latitude,
                                             longitude: longitude) { (result) in
            switch result{
            case .success(let weather):
                //print(weather)
                completion(weather)
            case .failure(let err):
                print(err)
                completion(nil)
                
            }
        }
    }
    
    func getLocationDailyTemp(latitude : String, longitude : String, completion:@escaping(DailyWeather?)->Void){
        APIManager.sharedInstance.getDailyWeather(latitude: latitude,
                                             longitude: longitude) { (result) in
            switch result{
            case .success(let weather):
                //print(weather)
                completion(weather)
            case .failure(let err):
                print(err)
                completion(nil)
                
            }
        }
    }
}

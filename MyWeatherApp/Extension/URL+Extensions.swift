//
//  URL+Extensions.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import Foundation

let APIKEY = "fae7190d7e6433ec3a45285ffcf55c86"

extension URL {
    
    static func urlForWeatherFor( latitude: String,longitude : String) -> URL? {
        //http://api.openweathermap.org/data/2.5/weather?lat=26.81908131600708&lon=80.49952338449657&appid=fae7190d7e6433ec3a45285ffcf55c86
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(APIKEY)") else {
            return nil
        }
        
        return url
        
    }
    
    static func urlForDailyWeatherFor( latitude: String,longitude : String) -> URL? {
        //http://api.openweathermap.org/data/2.5/forecast?lat=0&lon=0&appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(APIKEY)") else {
            return nil
        }
        
        return url
        
    }
}

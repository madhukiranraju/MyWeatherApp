//
//  WeatherResponse.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import Foundation


struct WindDetails : Decodable{
    let deg : Int
    let speed : Float
}

struct WeatherResponse: Decodable {
    var main: Weather
    var wind: WindDetails
    var weather: [WeatherDetails]
    var name : String
}

struct WeatherDetails: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
struct WeatherDaily: Decodable {
    let dt : Int?
    let dt_txt : String?
    let main: Weather
    let weather : [WeatherDetails]
}
struct DailyWeather : Decodable {
    let list : [WeatherDaily]
    let cod : String
    let cnt : Int
}

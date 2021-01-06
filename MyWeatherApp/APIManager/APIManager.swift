//
//  APIManager.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class APIManager{
    
    static let sharedInstance = APIManager()
    private init(){}
    
    func getWeather(latitude: String,longitude : String,completion: @escaping (Result<WeatherResponse?, NetworkError>) -> Void) {
        
        guard let url = URL.urlForWeatherFor(latitude: latitude, longitude: longitude) else {
            return completion(.failure(.badUrl))
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
//            let outputStr  = String(data: data, encoding: String.Encoding.utf8) as String?
            //print(outputStr)
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
    
    func getDailyWeather(latitude: String,longitude : String,completion: @escaping (Result<DailyWeather?, NetworkError>) -> Void) {
        
        guard let url = URL.urlForDailyWeatherFor(latitude: latitude, longitude: longitude) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let dailyweatherResponse = try? JSONDecoder().decode(DailyWeather.self, from: data)
//            print(dailyweatherResponse?.cod)
            if let dailyweatherResponse = dailyweatherResponse {
                completion(.success(dailyweatherResponse))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
}

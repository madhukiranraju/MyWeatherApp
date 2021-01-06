//
//  String+Extensions.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//
import Foundation

extension String {
    
    func escaped() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
}

//
//  MapViewModel.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import Foundation

class MapViewModel{
    
    static let sharedInstance = MapViewModel()
    //not allowing accidental init
    private init(){}
    
    func insertPlaceIntoDB(place : Place,completion : @escaping(Bool)->(Void)){
        //DataManager.sharedInstance.insertFavPlace(item: place)
        do {
            try DataManager.sharedInstance.insertFavPlace(item: place)
            completion(true)
        }catch{
            completion(false)
        }
        
    }
    
    
}

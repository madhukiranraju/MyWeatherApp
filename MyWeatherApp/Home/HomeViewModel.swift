//
//  HomeViewModel.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import Foundation

class HomeViewModel{
    static let sharedInstance = HomeViewModel()
    private init(){}
    
    func fetchPlaces(completion:@escaping([Place]?)->Void){
        var favoritePlaces = [Place]()
        
        do {
            let places = try DataManager.sharedInstance.fetchObjects()
            
            if places.count > 0{
                places.forEach { (fav) in
                    let fav = Place(placeName: fav.placeName,
                                    latitude: fav.latitude,
                                    longitude: fav.longitude,
                                    uuid: fav.uuid)
                    favoritePlaces.append(fav)
                }
                completion(favoritePlaces)
                //                return
            }else{
                completion(nil)
            }
        } catch  {
            completion(nil)
        }
    }
    
    
    func deleteFavorite(place : Place,completion:@escaping(Bool)->Void){
        do{
            try DataManager.sharedInstance.deleteFavPlace(place: place)
            completion(true)
        }catch{
            completion(false)
        }
    }
    
    
}

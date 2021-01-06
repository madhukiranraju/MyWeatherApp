//
//  DataManager.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import Foundation
import CoreData
import UIKit

class DataManager{
    
    static let sharedInstance = DataManager()
    let mc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func insertFavPlace(item : Place){
        
    }
    
}

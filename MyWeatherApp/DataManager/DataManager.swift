//
//  DataManager.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import Foundation
import CoreData
import UIKit

enum DataManagerError:Error{
    case failed
}

class DataManager{
    
    static let sharedInstance = DataManager()
    
    //not allowing accidental init
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //Inserting Data into CoreData
    /**
     @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
         return NSFetchRequest<Favorites>(entityName: "Favorites")
     }

     @NSManaged public var placeName: String?
     @NSManaged public var latitude: String?
     @NSManaged public var longitude: String?
     */
    func insertFavPlace(item : Place)throws{
        
        var thrownError: DataManagerError?
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = self.context
     
        privateContext.performAndWait{
            do{
                let favObj = Favorites(context: privateContext)
                favObj.placeName = item.placeName
                favObj.latitude = item.latitude
                favObj.longitude = item.longitude
                privateContext.insert(favObj)
                try privateContext.save()
                try self.context.save()
            }catch {
                print("Error failed to insert \(error)")
                thrownError = DataManagerError.failed
            }
        }
        if let error = thrownError {
            throw error
        }
    }
    
    func fetchObjects() throws -> [Favorites]{
        let fetchrequest = NSFetchRequest<Favorites>(entityName: "Favorites")
        do {
            let results = try context.fetch(fetchrequest)
            return results
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return []
    }
    
}

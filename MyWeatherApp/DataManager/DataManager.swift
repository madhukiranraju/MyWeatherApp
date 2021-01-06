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

public class DataManager{
    
    static let sharedInstance = DataManager()
    
    //not allowing accidental init
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //Inserting Data into CoreData

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
                favObj.uuid = item.uuid
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
    
    func deleteFavPlace(place : Place) throws{
        
        guard let uuid = place.uuid else {
            return
        }
        
        let fetchrequest = NSFetchRequest<Favorites>(entityName: "Favorites")
        fetchrequest.predicate = NSPredicate.init(format:"uuid==%@",uuid )
        do {
            let objects = try context.fetch(fetchrequest)
            for object in objects {
                context.delete(object)
            }
            try context.save()
        } catch _ {
            throw DataManagerError.failed
            // error handling
        }
    }
    
    func removeAllFavorites(){
        let deleteFetch = NSFetchRequest<Favorites>(entityName: "Favorites")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}

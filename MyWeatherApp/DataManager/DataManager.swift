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
    
    lazy var context = persistentContainer.viewContext
    
    
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

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MyWeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

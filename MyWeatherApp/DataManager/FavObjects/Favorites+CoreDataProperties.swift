//
//  Favorites+CoreDataProperties.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var placeName: String?
    @NSManaged public var uuid: String?

}

extension Favorites : Identifiable {

}

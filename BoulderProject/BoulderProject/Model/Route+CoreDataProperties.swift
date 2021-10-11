//
//  Route+CoreDataProperties.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/29/21.
//
//

import Foundation
import CoreData


extension Route {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Route> {
        return NSFetchRequest<Route>(entityName: "Route")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imageData: Data?
    @NSManaged public var color: RouteColor?
    @NSManaged public var grade: Grade?
    @NSManaged public var gym: Gym?

}

extension Route : Identifiable {

}

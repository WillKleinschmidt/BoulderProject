//
//  Gym+CoreDataProperties.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/29/21.
//
//

import Foundation
import CoreData


extension Gym {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gym> {
        return NSFetchRequest<Gym>(entityName: "Gym")
    }

    @NSManaged public var gymName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var routes: NSSet?

}

// MARK: Generated accessors for routes
extension Gym {

    @objc(addRoutesObject:)
    @NSManaged public func addToRoutes(_ value: Route)

    @objc(removeRoutesObject:)
    @NSManaged public func removeFromRoutes(_ value: Route)

    @objc(addRoutes:)
    @NSManaged public func addToRoutes(_ values: NSSet)

    @objc(removeRoutes:)
    @NSManaged public func removeFromRoutes(_ values: NSSet)

}

extension Gym : Identifiable {

}

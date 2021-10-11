//
//  RouteColor+CoreDataProperties.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/29/21.
//
//

import Foundation
import CoreData


extension RouteColor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RouteColor> {
        return NSFetchRequest<RouteColor>(entityName: "RouteColor")
    }

    @NSManaged public var colorName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var colorData: Data?
    @NSManaged public var routes: NSSet?

}

// MARK: Generated accessors for routes
extension RouteColor {

    @objc(addRoutesObject:)
    @NSManaged public func addToRoutes(_ value: Route)

    @objc(removeRoutesObject:)
    @NSManaged public func removeFromRoutes(_ value: Route)

    @objc(addRoutes:)
    @NSManaged public func addToRoutes(_ values: NSSet)

    @objc(removeRoutes:)
    @NSManaged public func removeFromRoutes(_ values: NSSet)

}

extension RouteColor : Identifiable {

}

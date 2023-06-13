//
//  Club+CoreDataProperties.swift
//  GolfProto04
//
//  Created by Philip Nye on 21/04/2023.
//
//

import Foundation
import CoreData
import UIKit


extension Club {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Club> {
        return NSFetchRequest<Club>(entityName: "Club")
    }

    @NSManaged public var addressLine1: String?
    @NSManaged public var addressLine2: String?
    @NSManaged public var addressLine3: String?
    @NSManaged public var addressLine4: String?
    @NSManaged public var clubImage: UIImage?
    @NSManaged public var distMetric: Int16
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var postCode: String?
    @NSManaged public var courses: NSSet?
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    public var wrappedAddressLine1: String {
        addressLine1 ?? "Unkown address line 1"
    }
    
    public var wrappedAddressLine2: String {
        addressLine2 ?? "Unkown address line 2"
    }
    
    public var wrappedAddressLine3: String {
        addressLine3 ?? "Unkown address line 3"
    }
    
    public var wrappedAddressLine4: String {
        addressLine4 ?? "Unkown address line 4"
    }
    
    public var wrappedPostCode: String {
        postCode ?? "Unkown post code"
    }
    
    
    
    public var wrappedEmail: String {
        email ?? "Unkown email"
    }
    
    public var courseArray: [Course] {
        let set = courses as? Set<Course> ?? []
        return set.sorted {
            $0.name ?? "" < $1.name ??  ""
        }
    }
}

// MARK: Generated accessors for courses
extension Club {

    @objc(addCoursesObject:)
    @NSManaged public func addToCourses(_ value: Course)

    @objc(removeCoursesObject:)
    @NSManaged public func removeFromCourses(_ value: Course)

    @objc(addCourses:)
    @NSManaged public func addToCourses(_ values: NSSet)

    @objc(removeCourses:)
    @NSManaged public func removeFromCourses(_ values: NSSet)

}

extension Club : Identifiable {

}

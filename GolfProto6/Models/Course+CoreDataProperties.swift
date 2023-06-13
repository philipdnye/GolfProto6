//
//  Course+CoreDataProperties.swift
//  GolfProto04
//
//  Created by Philip Nye on 21/04/2023.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var name: String?
    @NSManaged public var club: Club?
    @NSManaged public var teeBoxes: NSSet?

    public var teeBoxArray: [TeeBox] {
        let set = teeBoxes as? Set<TeeBox> ?? []
        return set.sorted {
            $0.courseRating < $1.courseRating
        }
    }
    
    
}

// MARK: Generated accessors for teeBoxes
extension Course {

    @objc(addTeeBoxesObject:)
    @NSManaged public func addToTeeBoxes(_ value: TeeBox)

    @objc(removeTeeBoxesObject:)
    @NSManaged public func removeFromTeeBoxes(_ value: TeeBox)

    @objc(addTeeBoxes:)
    @NSManaged public func addToTeeBoxes(_ values: NSSet)

    @objc(removeTeeBoxes:)
    @NSManaged public func removeFromTeeBoxes(_ values: NSSet)

}

extension Course : Identifiable {

}

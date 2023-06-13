//
//  TeamTeeBox+CoreDataProperties.swift
//  GolfProto04
//
//  Created by Philip Nye on 23/04/2023.
//
//

import Foundation
import CoreData
import UIKit


extension TeamTeeBox {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamTeeBox> {
        return NSFetchRequest<TeamTeeBox>(entityName: "TeamTeeBox")
    }

    @NSManaged public var courseRating: Double
    @NSManaged public var slopeRating: Int16
    @NSManaged public var color: UIColor?
    @NSManaged public var team: Int16
    @NSManaged public var teeBoxColour: String?
    @NSManaged public var game: Game?

}

extension TeamTeeBox : Identifiable {

}

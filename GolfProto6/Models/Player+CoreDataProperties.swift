//
//  Player+CoreDataProperties.swift
//  GolfProto04
//
//  Created by Philip Nye on 21/04/2023.
//
//

import Foundation
import CoreData
import UIKit

extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var gender: Int16
    @NSManaged public var mobile: String?
    @NSManaged public var photo: UIImage?
    @NSManaged public var selectedForGame: Bool
    @NSManaged public var competitors: NSSet?
    @NSManaged public var handicap: NSSet?
   
    public var handicapArray: [Handicap] {
        let set = handicap as? Set<Handicap> ?? []
        return set.sorted {
            $0.startDate ?? Date() > $1.startDate ?? Date()
        }
    }
    public var competitorArray: [Competitor] {
        let set = competitors as? Set<Competitor> ?? []
        return set.sorted {
            $0.player?.lastName ?? "" < $1.player?.lastName ?? ""
            
        }
    }
}

// MARK: Generated accessors for competitors
extension Player {

    @objc(addCompetitorsObject:)
    @NSManaged public func addToCompetitors(_ value: Competitor)

    @objc(removeCompetitorsObject:)
    @NSManaged public func removeFromCompetitors(_ value: Competitor)

    @objc(addCompetitors:)
    @NSManaged public func addToCompetitors(_ values: NSSet)

    @objc(removeCompetitors:)
    @NSManaged public func removeFromCompetitors(_ values: NSSet)

}

// MARK: Generated accessors for handicap
extension Player {

    @objc(addHandicapObject:)
    @NSManaged public func addToHandicap(_ value: Handicap)

    @objc(removeHandicapObject:)
    @NSManaged public func removeFromHandicap(_ value: Handicap)

    @objc(addHandicap:)
    @NSManaged public func addToHandicap(_ values: NSSet)

    @objc(removeHandicap:)
    @NSManaged public func removeFromHandicap(_ values: NSSet)

}

extension Player : Identifiable {

}

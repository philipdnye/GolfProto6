//
//  Competitor+CoreDataProperties.swift
//  GolfProto04
//
//  Created by Philip Nye on 23/04/2023.
//
//

import Foundation
import CoreData
import UIKit

extension Competitor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Competitor> {
        return NSFetchRequest<Competitor>(entityName: "Competitor")
    }

    @NSManaged public var courseHandicap: Double
    @NSManaged public var diffTeesXShots: Double
    @NSManaged public var handicapAllowance: Double
    @NSManaged public var handicapIndex: Double
    @NSManaged public var playingHandicap: Double
    @NSManaged public var shotsRecdMatch: Double
    @NSManaged public var team: Int16
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var gender: Int16
    @NSManaged public var color: UIColor?
    @NSManaged public var teeBoxColour: String?
    @NSManaged public var courseRating: Double
    @NSManaged public var slopeRating: Int16
    @NSManaged public var game: Game?
    @NSManaged public var player: Player?
    @NSManaged public var teeBox: TeeBox?
    @NSManaged public var scores: NSSet?
    
    public var competitorScoresArray: [CompetitorScore]{
        let set = scores as? Set<CompetitorScore> ?? []
        return set.sorted {
            $0.hole < $1.hole
        }
    }

}

// MARK: Generated accessors for scores
extension Competitor {

    @objc(addScoresObject:)
    @NSManaged public func addToScores(_ value: CompetitorScore)

    @objc(removeScoresObject:)
    @NSManaged public func removeFromScores(_ value: CompetitorScore)

    @objc(addScores:)
    @NSManaged public func addToScores(_ values: NSSet)

    @objc(removeScores:)
    @NSManaged public func removeFromScores(_ values: NSSet)

}

extension Competitor : Identifiable {

}

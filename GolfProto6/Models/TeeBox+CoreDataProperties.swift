//
//  TeeBox+CoreDataProperties.swift
//  GolfProto04
//
//  Created by Philip Nye on 26/04/2023.
//
//

import Foundation
import CoreData
import UIKit


extension TeeBox {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeeBox> {
        return NSFetchRequest<TeeBox>(entityName: "TeeBox")
    }

    @NSManaged public var colour: String?
    @NSManaged public var courseRating: Double
    @NSManaged public var slopeRating: Int16
    @NSManaged public var teeBoxColor: UIColor?
    @NSManaged public var competitors: NSSet?
    @NSManaged public var course: Course?
    @NSManaged public var game: NSSet?
    @NSManaged public var gameForDiffTees: NSSet?
    @NSManaged public var holes: NSSet?
    @NSManaged public var gameForScoreEntry: NSSet?

    public var holesArray: [Hole] {
            let set = holes as? Set<Hole> ?? []
            return set.sorted {
                $0.number < $1.number
            }
        }
    
    
    public var holesArray_front9: [Hole] {
            let set = holes as? Set<Hole> ?? []
        let filteredSet = set.filter({$0.number < 10})
            let sortedSet = filteredSet.sorted {
                $0.number < $1.number
            }
       return Array(sortedSet)
        }
        
    public var holesArray_back9: [Hole] {
            let set = holes as? Set<Hole> ?? []
        let filteredSet = set.filter({$0.number > 9})
            let sortedSet = filteredSet.sorted {
                $0.number < $1.number
            }
       return Array(sortedSet)
        }
    
    
    
    
        public var wrappedColour: String {
            colour ?? "Unknown colour"
        }

    
}

// MARK: Generated accessors for competitors
extension TeeBox {

    @objc(addCompetitorsObject:)
    @NSManaged public func addToCompetitors(_ value: Competitor)

    @objc(removeCompetitorsObject:)
    @NSManaged public func removeFromCompetitors(_ value: Competitor)

    @objc(addCompetitors:)
    @NSManaged public func addToCompetitors(_ values: NSSet)

    @objc(removeCompetitors:)
    @NSManaged public func removeFromCompetitors(_ values: NSSet)

}

// MARK: Generated accessors for game
extension TeeBox {

    @objc(addGameObject:)
    @NSManaged public func addToGame(_ value: Game)

    @objc(removeGameObject:)
    @NSManaged public func removeFromGame(_ value: Game)

    @objc(addGame:)
    @NSManaged public func addToGame(_ values: NSSet)

    @objc(removeGame:)
    @NSManaged public func removeFromGame(_ values: NSSet)

}

// MARK: Generated accessors for gameForDiffTees
extension TeeBox {

    @objc(addGameForDiffTeesObject:)
    @NSManaged public func addToGameForDiffTees(_ value: Game)

    @objc(removeGameForDiffTeesObject:)
    @NSManaged public func removeFromGameForDiffTees(_ value: Game)

    @objc(addGameForDiffTees:)
    @NSManaged public func addToGameForDiffTees(_ values: NSSet)

    @objc(removeGameForDiffTees:)
    @NSManaged public func removeFromGameForDiffTees(_ values: NSSet)

}

// MARK: Generated accessors for holes
extension TeeBox {

    @objc(addHolesObject:)
    @NSManaged public func addToHoles(_ value: Hole)

    @objc(removeHolesObject:)
    @NSManaged public func removeFromHoles(_ value: Hole)

    @objc(addHoles:)
    @NSManaged public func addToHoles(_ values: NSSet)

    @objc(removeHoles:)
    @NSManaged public func removeFromHoles(_ values: NSSet)

}

// MARK: Generated accessors for gameForScoreEntry
extension TeeBox {

    @objc(addGameForScoreEntryObject:)
    @NSManaged public func addToGameForScoreEntry(_ value: Game)

    @objc(removeGameForScoreEntryObject:)
    @NSManaged public func removeFromGameForScoreEntry(_ value: Game)

    @objc(addGameForScoreEntry:)
    @NSManaged public func addToGameForScoreEntry(_ values: NSSet)

    @objc(removeGameForScoreEntry:)
    @NSManaged public func removeFromGameForScoreEntry(_ values: NSSet)

}

extension TeeBox : Identifiable {

}

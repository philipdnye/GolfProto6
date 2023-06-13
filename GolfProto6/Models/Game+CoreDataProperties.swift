//
//  Game+CoreDataProperties.swift
//  GolfProto04
//
//  Created by Philip Nye on 26/04/2023.
//
//

import Foundation
import CoreData
import UIKit


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var clubName: String?
    @NSManaged public var courseName: String?
    @NSManaged public var date: Date?
    @NSManaged public var distMetric: Int16
    @NSManaged public var dTB_Color: String?
    @NSManaged public var dTB_courseRating: Double
    @NSManaged public var dTB_slopeRating: Int16
    @NSManaged public var dTB_teeBoxColour: UIColor?
    @NSManaged public var duration: Int16
    @NSManaged public var finished: Bool
    @NSManaged public var finishTime: Date?
    @NSManaged public var gameFormat: Int16
    @NSManaged public var handicapFormat: Int16
    @NSManaged public var name: String?
    @NSManaged public var playFormat: Int16
    @NSManaged public var scoreFormat: Int16
    @NSManaged public var started: Bool
    @NSManaged public var startingHole: Int16
    @NSManaged public var startTime: Date?
    @NSManaged public var competitors: NSSet?
    @NSManaged public var defaultTeeBox: TeeBox?
    @NSManaged public var diffTeesTeeBox: TeeBox?
    @NSManaged public var teamScores: NSSet?
    @NSManaged public var teamShots: NSSet?
    @NSManaged public var teamTeeBoxes: NSSet?
    @NSManaged public var scoreEntryTeeBox: TeeBox?

    public var competitorArray: [Competitor] {
                let set = competitors as? Set<Competitor> ?? []
                return set.sorted {
                    $0.id < $1.id
                }
            }
    
    public var competitorArraySortedAB: [Competitor] {
                let set = competitors as? Set<Competitor> ?? []
                return set.sorted {
                    $0.team < $1.team
                }
            }
        
        public var teamShotsArray: [TeamShots]{
            let set = teamShots as? Set<TeamShots> ?? []
            return set.sorted {
                $0.team < $1.team
            }
        }
        public var teamScoresArray: [TeamScore]{
            let set = teamScores as? Set<TeamScore> ?? []
            return set.sorted {
                $0.team < $1.team
            }
        }
    public var teamAScoresArray: [TeamScore]{
        let set = teamScores as? Set<TeamScore> ?? []
        let filteredSet = set.filter({$0.team == 0})
        return filteredSet.sorted {
            $0.hole < $1.hole
        }
    }
    public var teamBScoresArray: [TeamScore]{
        let set = teamScores as? Set<TeamScore> ?? []
        let filteredSet = set.filter({$0.team == 1})
        return filteredSet.sorted {
            $0.hole < $1.hole
        }
    }
    public var teamCScoresArray: [TeamScore]{
        let set = teamScores as? Set<TeamScore> ?? []
        let filteredSet = set.filter({$0.team == 2})
        return filteredSet.sorted {
            $0.hole < $1.hole
        }
    }
    
    
        public var teamTeeBoxArray: [TeamTeeBox]{
            let set = teamTeeBoxes as? Set<TeamTeeBox> ?? []
            return set.sorted {
                $0.team < $1.team
            }
        }

    
}

// MARK: Generated accessors for competitors
extension Game {

    @objc(addCompetitorsObject:)
    @NSManaged public func addToCompetitors(_ value: Competitor)

    @objc(removeCompetitorsObject:)
    @NSManaged public func removeFromCompetitors(_ value: Competitor)

    @objc(addCompetitors:)
    @NSManaged public func addToCompetitors(_ values: NSSet)

    @objc(removeCompetitors:)
    @NSManaged public func removeFromCompetitors(_ values: NSSet)

}

// MARK: Generated accessors for teamScores
extension Game {

    @objc(addTeamScoresObject:)
    @NSManaged public func addToTeamScores(_ value: TeamScore)

    @objc(removeTeamScoresObject:)
    @NSManaged public func removeFromTeamScores(_ value: TeamScore)

    @objc(addTeamScores:)
    @NSManaged public func addToTeamScores(_ values: NSSet)

    @objc(removeTeamScores:)
    @NSManaged public func removeFromTeamScores(_ values: NSSet)

}

// MARK: Generated accessors for teamShots
extension Game {

    @objc(addTeamShotsObject:)
    @NSManaged public func addToTeamShots(_ value: TeamShots)

    @objc(removeTeamShotsObject:)
    @NSManaged public func removeFromTeamShots(_ value: TeamShots)

    @objc(addTeamShots:)
    @NSManaged public func addToTeamShots(_ values: NSSet)

    @objc(removeTeamShots:)
    @NSManaged public func removeFromTeamShots(_ values: NSSet)

}

// MARK: Generated accessors for teamTeeBoxes
extension Game {

    @objc(addTeamTeeBoxesObject:)
    @NSManaged public func addToTeamTeeBoxes(_ value: TeamTeeBox)

    @objc(removeTeamTeeBoxesObject:)
    @NSManaged public func removeFromTeamTeeBoxes(_ value: TeamTeeBox)

    @objc(addTeamTeeBoxes:)
    @NSManaged public func addToTeamTeeBoxes(_ values: NSSet)

    @objc(removeTeamTeeBoxes:)
    @NSManaged public func removeFromTeamTeeBoxes(_ values: NSSet)

}

extension Game : Identifiable {

}

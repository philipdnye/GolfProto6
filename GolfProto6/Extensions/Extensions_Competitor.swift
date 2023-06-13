//
//  Extensions_Competitor.swift
//  GolfProto03
//
//  Created by Philip Nye on 16/04/2023.
//

import Foundation


extension Competitor {
    func CourseHandicap() -> Double {
        let CH = (self.player?.handicapArray.currentHandicapIndex() ?? 0.0)*Double(self.teeBox?.slopeRating ?? 0)/113
        return CH
    }
}
extension Competitor {
    func FirstName() -> String {
        let FN = (self.player?.firstName ?? "")
        return FN
    }
}
extension Competitor {
    func LastName() -> String {
        let LN = (self.player?.lastName ?? "")
        return LN
    }
}
extension Competitor {
    func TeeBoxColour() -> String {
        let TBC = (self.teeBox?.wrappedColour ?? "")
        return TBC
    }
}

extension Competitor {
    func CourseRating() -> Double {
        let CR = self.teeBox?.courseRating ?? 70.0
        return CR
    }
}

extension Competitor {
    func SlopeRating() -> Int {
        let SR = Int(self.teeBox?.slopeRating ?? 122)
        return SR
    }
}
extension Competitor {
    var team_String: TeamAssignment {
        get{
            return TeamAssignment(rawValue: Int(self.team)) ?? .indiv
        } set {
            self.team = Int16(newValue.rawValue)
        }
    }
}

extension Competitor {
    func TotalPlayingHandicap (currentGF: CurrentGameFormat) -> Double {
        let totalPH = Double(round(self.playingHandicap) + (round(self.diffTeesXShots)*currentGF.extraShotsTeamAdj))
        return totalPH
    }
}
extension Competitor {
    func TotalPlayingHandicapUnrounded (currentGF: CurrentGameFormat) -> Double {
        let totalPH = Double(self.playingHandicap + (self.diffTeesXShots * currentGF.extraShotsTeamAdj))
        return totalPH
    }
}


extension Competitor {
    func TotalAdjustedExtraShotsUnrounded (currentGF: CurrentGameFormat) -> Double {
        let total = Double(self.diffTeesXShots * currentGF.extraShotsTeamAdj)
        return total
    }
}

extension Competitor {
    func TotalShotsRecdMatch () -> Double {
        let totalSR = Double(self.shotsRecdMatch + self.diffTeesXShots)
        return totalSR
    }
}


extension Competitor {
    func ShotsReceived(holeIndex: Int, shots: Double) -> Int {
        
        var shots18Recd: Int = 0
        var shots36Recd: Int = 0
        var shots54Recd: Int = 0
      
        let shots18 = Int(round(shots))
        var shots36 = Int(round(shots - 18))
        if shots36 < 0 {shots36 = 0}
        var shots54 = Int(round(shots - 36))
        if shots54 < 0 {shots54 = 0}
     
        if shots18 >= self.competitorScoresArray[holeIndex].strokeIndex {shots18Recd = 1}
        if shots36 >= self.competitorScoresArray[holeIndex].strokeIndex {shots36Recd = 1}
        if shots54 >= self.competitorScoresArray[holeIndex].strokeIndex {shots54Recd = 1}
        
        let shotsReceived = shots18Recd + shots36Recd + shots54Recd
        return shotsReceived
    }
}




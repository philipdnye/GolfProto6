//
//  Extensions_TeamScore.swift
//  GolfProto05
//
//  Created by Philip Nye on 12/05/2023.
//

import Foundation

extension  TeamScore {
    func StablefordPointsNet () -> Int16 {
       var stablefordPoints: Int16 = 0
        stablefordPoints = self.par - (self.grossScore - self.shotsRecdHoleStroke) + 2
        if stablefordPoints < -2 {
            stablefordPoints = 0
        }
       return stablefordPoints
    }
}
extension  TeamScore {
    func StablefordPointsGross () -> Int16 {
       var stablefordPoints: Int16 = 0
        stablefordPoints = self.par - self.grossScore + 2
        if stablefordPoints < -2 {
            stablefordPoints = 0
        }
       return stablefordPoints
    }
}


extension TeamScore {
    func NetScoreMatch () -> Int16 {
        var netScore: Int16 = 0
        if self.scoreCommitted {
            netScore = self.grossScore - self.shotsRecdHoleMatch
        } else {
            netScore = 0
        }
        return netScore
    }
}
extension TeamScore {
    var team_String: TeamAssignment {
        get{
            return TeamAssignment(rawValue: Int(self.team)) ?? .indiv
        } set {
            self.team = Int16(newValue.rawValue)
        }
    }
}



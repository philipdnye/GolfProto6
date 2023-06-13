//
//  Extensions_CompetitorScore.swift
//  GolfProto04
//
//  Created by Philip Nye on 08/05/2023.
//

import Foundation


extension  CompetitorScore {
    func StablefordPointsNet () -> Int16 {
       var stablefordPoints: Int16 = 0
        stablefordPoints = self.par - (self.grossScore - self.shotsRecdHoleStroke) + 2
        if stablefordPoints < -2 {
            stablefordPoints = 0
        }
       return stablefordPoints
    }
}
extension  CompetitorScore {
    func StablefordPointsGross () -> Int16 {
       var stablefordPoints: Int16 = 0
        stablefordPoints = self.par - self.grossScore + 2
        if stablefordPoints < -2 {
            stablefordPoints = 0
        }
       return stablefordPoints
    }
}


extension CompetitorScore {
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

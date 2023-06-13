//
//  Extensions_CompetitorScoreArray.swift
//  GolfProto04
//
//  Created by Philip Nye on 27/04/2023.
//

import Foundation

extension [CompetitorScore] {
    func TotalGrossScore_front9() -> Int16 {
        var total:Int16 = 0
        for hole in self.filter({$0.hole < 10}) {
            if (hole as AnyObject).scoreCommitted {
                total += (hole as AnyObject).grossScore
            }
        }
        
            return total
        
       
    }
}


extension [CompetitorScore] {
    func TotalGrossScore_back9() -> Int16 {
        var total:Int16 = 0
        for hole in self.filter({$0.hole > 9}) {
            if (hole as AnyObject).scoreCommitted {
                total += (hole as AnyObject).grossScore
            }
        }
        return total
    }
}


extension [CompetitorScore] {
    func TotalGrossScore() -> Int16 {
        var total:Int16 = 0
        for hole in self {
            if (hole as AnyObject).scoreCommitted {
                total += (hole as AnyObject).grossScore
            }
        }
        return total
    }
}


extension [CompetitorScore] {
    func TotalStablefordPoints_front9 () -> Int16 {
        var total: Int16 = 0
        for hole in self.filter({$0.hole < 10}) {
        
            if (hole as AnyObject).scoreCommitted {
                total += (hole.StablefordPointsNet())
            }
        }
        return total
    }
}
extension [CompetitorScore] {
    func TotalStablefordPoints_back9 () -> Int16 {
        var total: Int16 = 0
        for hole in self.filter({$0.hole > 9}) {
        
            if (hole as AnyObject).scoreCommitted {
                total += (hole.StablefordPointsNet())
            }
        }
        return total
    }
}
extension [CompetitorScore]{
    func TotalStablefordPoints () -> Int16 {
        var total: Int16 = 0
        for hole in self {
            if (hole as AnyObject).scoreCommitted {
                total += hole.StablefordPointsNet()
            }
        }
        return total
    }
}

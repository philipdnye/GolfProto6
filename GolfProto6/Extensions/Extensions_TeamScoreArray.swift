//
//  Extensions_TeamScoreArray.swift
//  GolfProto05
//
//  Created by Philip Nye on 12/05/2023.
//

import Foundation

extension [TeamScore] {
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


extension [TeamScore] {
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


extension [TeamScore] {
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

extension [TeamScore] {
    func TotalParSoFar() -> Int16 {
        var total:Int16 = 0
        for hole in self {
            if (hole as AnyObject).scoreCommitted {
                total += (hole as AnyObject).par
            }
        }
        return total
    }
}

extension [TeamScore] {
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

extension [TeamScore] {
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

extension [TeamScore]{
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

//
//  Extensions_HandicapArray.swift
//  GolfProto04
//
//  Created by Philip Nye on 21/04/2023.
//

import Foundation

extension Array where Element == Handicap {
    func currentHandicapIndex() -> Double {
//        let unDeleted = self.filter({ $0.deleted != true})
        
        if !self.isEmpty{
            let HI = self.reduce(self[0], {
                $0.startDate?.timeIntervalSince1970 ?? 0.0 >
                $1.startDate?.timeIntervalSince1970 ?? 0.0 ? $0 : $1
            })
            return HI.handicapIndex
        } else {
            return 0.0
        }
    }
}

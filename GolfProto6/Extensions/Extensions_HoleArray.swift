//
//  Extensions_HoleArray.swift
//  GolfProto04
//
//  Created by Philip Nye on 27/04/2023.
//

import Foundation

extension [Hole] {
    func TotalDistance() -> Int16 {
        var total:Int16 = 0
        for hole in self {
            total += (hole as AnyObject).distance
        }
        return total
    }
}



extension [Hole] {
    func TotalPar() -> Int16 {
        var total:Int16 = 0
        for hole in self {
            total += (hole as AnyObject).par
        }
        return total
    }
}

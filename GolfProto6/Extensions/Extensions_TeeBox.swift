//
//  Extensions_TeeBox.swift
//  GolfProto03
//
//  Created by Philip Nye on 18/04/2023.
//

import Foundation
extension TeeBox {
    func TotalDistance() -> Int16 {
        var total:Int16 = 0
        for hole in self.holes! {
            total += (hole as AnyObject).distance
        }
        return total
    }
}
extension TeeBox {
    func TotalPar() -> Int16 {
        var total:Int16 = 0
        for hole in self.holes! {
            total += (hole as AnyObject).par
        }
        return total
    }
}





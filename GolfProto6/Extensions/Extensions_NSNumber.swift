//
//  EXtension_NSNumber.swift
//  GolfProto04
//
//  Created by Philip Nye on 23/04/2023.
//

import Foundation
extension NSNumber {
    func getPercentage() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2 // You can set what you want
        return formatter.string(from: self)!
    }
}

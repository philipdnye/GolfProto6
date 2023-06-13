//
//  TestArray_Extension.swift
//  GolfProto03
//
//  Created by Philip Nye on 15/04/2023.
//

import Foundation

extension [Course] {
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}
extension [Club] {
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}

extension [TeeBox] {
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}
extension Club {
    var dist_metric: DistMetric {
        get {
            return DistMetric(rawValue: Int(self.distMetric)) ?? .yards
        } set {
            self.distMetric = Int16(newValue.rawValue)
        }
    }
}

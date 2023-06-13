//
//  Extensions_Player.swift
//  GolfProto03
//
//  Created by Philip Nye on 16/04/2023.
//

import Foundation

extension Player {
    func Initials() -> String {
        let firstInitial = String(self.firstName?.prefix(1).capitalized ?? "")
        let lastInitial = String(self.lastName?.prefix(1).capitalized ?? "")
        let initials = firstInitial + lastInitial
        return initials
    }
}

extension Player {
    var pl_gender: PlayerGender {
        get{
            return PlayerGender(rawValue: Int(self.gender)) ?? .male
        } set {
            self.gender = Int16(newValue.rawValue)
        }
    }
    func pl_genderInitial() -> String {
        let initial = String(self.pl_gender.stringValue().prefix(1).capitalized)
        return initial
    }
    
}

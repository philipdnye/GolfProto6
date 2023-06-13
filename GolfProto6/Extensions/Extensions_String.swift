//
//  Extensions_String.swift
//  GolfProto03
//
//  Created by Philip Nye on 19/04/2023.
//

import Foundation
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

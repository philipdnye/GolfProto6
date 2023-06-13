//
//  Extensions_Color.swift
//  GolfProto05
//
//  Created by Philip Nye on 13/05/2023.
//

import Foundation

import SwiftUI

extension Color {
    static subscript(name: String) -> Color {
        switch name {
            case "green":
                return Color.green
            case "red":
                return Color.red
            case "blue":
                return Color.blue
            default:
                return Color.accentColor
        }
    }
}

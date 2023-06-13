//
//  Extensions_Integer.swift
//  GolfProto05
//
//  Created by Philip Nye on 17/05/2023.
//

import Foundation


extension Int {
    func ScoreToParString() -> String {
        var scoreToParString: String = ""
        switch self {
        case _ where self > 0:
            scoreToParString = "(+\(self))"
        case _ where self < 0:
            scoreToParString = "(\(self))"
        case _ where self == 0:
            scoreToParString = "(level par)"
        default:
            scoreToParString = ""
        }
        return scoreToParString
    }
}

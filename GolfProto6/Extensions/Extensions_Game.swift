//
//  Extensions_Game.swift
//  GolfProto03
//
//  Created by Philip Nye on 14/04/2023.
//

import Foundation


extension Game {
    var sc_format: ScoreFormat {
        get{
            return ScoreFormat(rawValue: Int(self.scoreFormat)) ?? .medal
        } set {
            self.scoreFormat = Int16(newValue.rawValue)
        }
    }
}
extension Game {
    var hcap_format: HandicapFormat {
        get{
            return HandicapFormat(rawValue: Int(self.handicapFormat)) ?? .handicap
        } set {
            self.handicapFormat = Int16(newValue.rawValue)
        }
    }
}
extension Game {
    var play_format: PlayFormat {
        get{
            return PlayFormat(rawValue: Int(self.playFormat)) ?? .strokeplay
        } set {
            self.playFormat = Int16(newValue.rawValue)
        }
    }
}

extension Game {
    var game_format: GameFormatType {
        get{
            return GameFormatType(rawValue: Int(self.gameFormat)) ?? .fourBallBBMatch
        } set {
            self.gameFormat = Int16(newValue.rawValue)
        }
    }
}

extension Game {
    var game_duration: GameDuration {
        get {
            return GameDuration(rawValue: Int(self.duration)) ?? .H18
        } set {
            self.duration = Int16(newValue.rawValue)
        }
    }
}

extension Game {
    func TeeBoxesAllSame() -> Bool {
        var teeBoxes: [TeeBox] = []
        for i in 0..<self.competitorArray.count {
            teeBoxes.append(self.competitorArray[i].teeBox ?? TeeBox())
        }
        let hasAllItemsEqual = teeBoxes.dropFirst().reduce(true) { (partialResult, element) in
            return partialResult && element == teeBoxes.first
        }
        return hasAllItemsEqual
    }
}

extension Game {
    func AllScoresCommitted(holeIndex: Int) -> Bool {
        var scoresCommitted: [Bool] = []
        if self.competitorArray.first?.competitorScoresArray[holeIndex].scoreCommitted == true{
            for i in 0..<self.competitorArray.count {
                scoresCommitted.append(self.competitorArray[i].competitorScoresArray[holeIndex].scoreCommitted)
                
                //teeBoxes.append(self.competitorArray[i].teeBox ?? TeeBox())
            }
            let hasAllItemsEqual = scoresCommitted.dropFirst().reduce(true) { (partialResult, element) in
                return partialResult && element == scoresCommitted
                
                    .first
            }
            return hasAllItemsEqual
        } else {
            return false
        }
    }
}

extension Game {
    func AllScoresCommittedTeamAB(holeIndex: Int) -> Bool {
        var scoresCommitted: [Bool] = []
        if self.teamAScoresArray[holeIndex].scoreCommitted == true {
       
            scoresCommitted.append(self.teamAScoresArray[holeIndex].scoreCommitted)
            scoresCommitted.append(self.teamBScoresArray[holeIndex].scoreCommitted)
           
            let hasAllItemsEqual = scoresCommitted.dropFirst().reduce(true) { (partialResult, element) in
                return partialResult && element == scoresCommitted
                
                    .first
            }
            return hasAllItemsEqual
        } else {
            return false
        }
    }
}


extension Game {
    func TotalPlayingHandicapA () -> Double {
        if !self.teamShotsArray.isEmpty{
            let totalPHA = Double(self.teamShotsArray[0].playingHandicap + self.teamShotsArray[0].diffTeesXShots)
            
            return totalPHA
        } else {
            return 0.0
        }
    }
}
extension Game {
    func TotalPlayingHandicapB () -> Double {
        if !self.teamShotsArray.isEmpty{
            let totalPHB = Double(self.teamShotsArray[1].playingHandicap + self.teamShotsArray[1].diffTeesXShots)
            
            return totalPHB
        } else {
            return 0.0
        }
    }
}
extension Game {
    func TotalPlayingHandicapC () -> Double {
        if !self.teamShotsArray.isEmpty{
            let totalPHC = Double(self.teamShotsArray[2].playingHandicap + self.teamShotsArray[2].diffTeesXShots)
            
            return totalPHC
        } else {
            return 0.0
        }
    }
}

extension Game {
    func TotalShotsRecdMatchTeamA () -> Double {
        if !self.teamShotsArray.isEmpty{
            let totalSR = Double(self.teamShotsArray[0].shotsRecd + self.teamShotsArray[0].diffTeesXShots)
            
            return totalSR
        } else {
            return 0.0
        }
    }
}
extension Game {
    func TotalShotsRecdMatchTeamB () -> Double {
        if !self.teamShotsArray.isEmpty{
            let totalSR = Double(self.teamShotsArray[1].shotsRecd + self.teamShotsArray[1].diffTeesXShots)
            
            return totalSR
        } else {
            return 0.0
        }
    }
}

extension Game {
    func ShotsReceivedByTeam(holeIndex: Int, shots: Double, team: Int16) -> Int {
        
        var shots18Recd: Int = 0
        var shots36Recd: Int = 0
        var shots54Recd: Int = 0
      
        let shots18 = Int(round(shots))
        var shots36 = Int(round(shots - 18))
        if shots36 < 0 {shots36 = 0}
        var shots54 = Int(round(shots - 36))
        if shots54 < 0 {shots54 = 0}
     
        if shots18 >= self.teamScoresArray.filter({$0.team == team})[holeIndex].strokeIndex {shots18Recd = 1}//is the problem that the index doesnt work on filtered list???/
        if shots36 >= self.teamScoresArray.filter({$0.team == team})[holeIndex].strokeIndex {shots36Recd = 1}
        if shots54 >= self.teamScoresArray.filter({$0.team == team})[holeIndex].strokeIndex {shots54Recd = 1}
        
        let shotsReceived = shots18Recd + shots36Recd + shots54Recd
        return shotsReceived
    }
}

extension Game {
    func ShotsReceivedByTeamPerHole(strokeIndex: Int, shots: Double) -> Int {
        var shots18Recd: Int = 0
        var shots36Recd: Int = 0
        var shots54Recd: Int = 0

        let shots18 = Int(round(shots))
        var shots36 = Int(round(shots - 18))
        if shots36 < 0 {shots36 = 0}
        var shots54 = Int(round(shots - 36))
        if shots54 < 0 {shots54 = 0}
        
        if shots18 >= strokeIndex {shots18Recd = 1}
        if shots36 >= strokeIndex {shots36Recd = 1}
        if shots54 >= strokeIndex {shots54Recd = 1}

        let shotsReceived = shots18Recd + shots36Recd + shots54Recd
        return shotsReceived
    }
}

extension Game {
    func SortedCompetitorArray () -> [Competitor] {
        return self.competitorArray.sorted(by: {$0.playingHandicap < $1.playingHandicap})
    }
}
extension Game {
    func SortedCompetitors (currentGF: CurrentGameFormat) -> [Competitor] {
       
        var sortedCompetitors: [Competitor] = []
        switch currentGF.assignTeamGrouping {
            
        case .Indiv:
            sortedCompetitors = self.competitorArray.sorted(by: {
                
                if $0.handicapIndex == $1.handicapIndex {
                    if $0.player?.firstName ?? "" == $1.player?.firstName ?? "" {
                        return $0.player?.objectID.description ?? "" < $1.player?.objectID.description ?? ""}
                    
                    return $0.player?.firstName ?? "" < $1.player?.firstName ?? "" }
                    return $0.handicapIndex < $1.handicapIndex
                
            })
       
        case .TeamsAB:
            
            sortedCompetitors = self.competitorArray.sorted(by:{
                if $0.team == $1.team {
                    if $0.handicapIndex == $1.handicapIndex {
                        if $0.player?.firstName ?? "" == $1.player?.firstName ?? "" {
                            
                            
                            return $0.player?.objectID.description ?? "" < $1.player?.objectID.description ?? ""
                            
                        }
                        return $0.player?.firstName ?? "" < $1.player?.firstName ?? ""
                    }
                    return $0.handicapIndex < $1.handicapIndex
                }
                return $0.team < $1.team
            })
            
        case .TeamC:
            sortedCompetitors = self.competitorArray.sorted(by: {
               
                if $0.handicapIndex == $1.handicapIndex {
                    if $0.player?.firstName ?? "" == $1.player?.firstName ?? "" {
                        return $0.player?.objectID.description ?? "" < $1.player?.objectID.description ?? ""}
                    
                    return $0.player?.firstName ?? "" < $1.player?.firstName ?? "" }
                    return $0.handicapIndex < $1.handicapIndex
                
            })
            
            
        }
    return sortedCompetitors
    }
}





extension Game {
    //1 Calc the current match score eg 0, -1, +2 etc NB Does not work with Six Point Game - should be able to add this in.
    //returns current macth score AND the no of holes played ie with all scores committed. only need holeIndex variable when byHole == true
    func CalcCurrentMatchScore(currentGF: CurrentGameFormat, byHole: Bool, holeIndex: Int?) -> (Int,Int) {
        var teamA:[Competitor] = []
        var teamB:[Competitor] = []
        var teamAScores: [TeamScore] = []
        var teamBScores: [TeamScore] = []
        var teamANetLowScore: Int16 = 0
        var teamBNetLowScore: Int16 = 0
        var holesPlayed = 0
        var currentMatchScore = 0
        var noOfHoles:Int = 0
        
        
        switch currentGF.assignTeamGrouping{
        case .Indiv://need to filter out 6 point which wont have teams
            teamA = self.competitorArray.filter({$0.team_String == .teamA})
            teamB = self.competitorArray.filter({$0.team_String == .teamB})
        case .TeamsAB:
            switch currentGF.assignShotsRecd{
            case .TeamsAB://foursomes
                teamAScores = self.teamScoresArray.filter({$0.team == 0}).sorted(by: {$0.hole < $1.hole})
                teamBScores = self.teamScoresArray.filter({$0.team == 1}).sorted(by: {$0.hole < $1.hole})
                
            default://singles && 4BB
                
                teamA = self.competitorArray.filter({$0.team_String == .teamA})
                teamB = self.competitorArray.filter({$0.team_String == .teamB})
                
            }
        case .TeamC:
            break
            
        }//assign team grouping
        //if you call this function with by hole as false it will provide the overall match score, otherwise the current match score on that hole
        switch byHole {
        case false:
            noOfHoles = 18
        case true:
            noOfHoles = holeIndex ?? 0
        }
        
        
        
        for i in 0..<noOfHoles {
            
            
            //for 4BBB, 4BC, Singles, Six point
            switch currentGF.assignShotsRecd {
                
            case .Indiv:
                
                switch self.AllScoresCommitted(holeIndex: i){
                    
                    
                case true: // need to switch for 4BBB and 4Bcombined
                    
                    switch currentGF.noOfPlayersNeeded{
                    case 4:
                        
                        
                        switch currentGF.format {
                            //4BBB
                        case .fourBallBBMatch:
                            holesPlayed += 1
                            teamANetLowScore = min(teamA[0].competitorScoresArray[i].NetScoreMatch(),teamA[1].competitorScoresArray[i].NetScoreMatch() )
                            teamBNetLowScore = min(teamB[0].competitorScoresArray[i].NetScoreMatch(),teamB[1].competitorScoresArray[i].NetScoreMatch() )
                            
                            
                            //4BCombined
                        case .fourBallCombinedMatch:
                            holesPlayed += 1
                            teamANetLowScore = teamA[0].competitorScoresArray[i].NetScoreMatch() + teamA[1].competitorScoresArray[i].NetScoreMatch()
                            teamBNetLowScore = teamB[0].competitorScoresArray[i].NetScoreMatch() + teamB[1].competitorScoresArray[i].NetScoreMatch()
                        default:
                            break
                            
                        }
                        
                    case 2: //singles
                        holesPlayed += 1
                        teamANetLowScore = Int16(teamA.first?.competitorScoresArray[i].NetScoreMatch() ?? 0)
                        teamBNetLowScore = Int16(teamB.first?.competitorScoresArray[i].NetScoreMatch() ?? 0)
                        
                    default:
                        break //use this for 6 point????
                    }
                    
                    //only altering currentMAtchScore when all scores have been committed
                    switch teamANetLowScore - teamBNetLowScore {
                        
                    case _ where teamANetLowScore - teamBNetLowScore < 0:
                        currentMatchScore += 1
                        
                    case _ where teamANetLowScore - teamBNetLowScore > 0:
                        currentMatchScore -= 1
                    default:
                        break
                    }
                    
                    
                    
                    
                    
                case false:
                    break
                    
                    
                }
                
                
            case .TeamsAB:
                switch self.AllScoresCommittedTeamAB(holeIndex: i){
                    
                case true:
                    holesPlayed += 1
                    teamANetLowScore = teamAScores[i].NetScoreMatch()
                    teamBNetLowScore = teamBScores[i].NetScoreMatch()
                    
                    switch teamANetLowScore - teamBNetLowScore {
                        
                    case _ where teamANetLowScore - teamBNetLowScore < 0:
                        currentMatchScore += 1
                        
                    case _ where teamANetLowScore - teamBNetLowScore > 0:
                        currentMatchScore -= 1
                    default:
                        break
                    }
                    
                    
                    
                    
                case false:
                    break
                }
                
            case .TeamC:
                break
                
            }
            
            
            
        } // for i in
        
        return (currentMatchScore, holesPlayed)
    }
    
    //2 Return a string with the current overall match score, based on (1). 1st string is current score, 2nd string is the no. of holes remaining
    func CurrentMatchScoreString(currentMatchScore: Int, holesPlayed: Int, currentGF: CurrentGameFormat) -> (String, String) {
        
        var result = ""
        var playerA: String = ""
        var playerB: String = ""
        var teamAPlayers: String = ""
        var teamBPlayers: String = ""
        var holesRemainingString: String = ""
        let holesRemaining = 18 - holesPlayed
        if holesRemaining > 1 {
            holesRemainingString = " \(holesRemaining) holes remaining"
        } else {
            holesRemainingString = " \(holesRemaining) hole remaining"
        }
        
        if currentGF.assignShotsRecd == .Indiv {
            switch currentGF.noOfPlayersNeeded {
            case 2://singles matchplay
                playerA = "\(self.competitorArray.filter({$0.team_String == .teamA}).first?.player?.firstName?.capitalized ?? "") \(self.competitorArray.filter({$0.team_String == .teamA}).first?.player?.lastName?.prefix(1).capitalized ?? "")"
                
                playerB = "\(self.competitorArray.filter({$0.team_String == .teamB}).first?.player?.firstName?.capitalized ?? "") \(self.competitorArray.filter({$0.team_String == .teamB}).first?.player?.lastName?.prefix(1).capitalized ?? "")"
            case 4://4bbb etc
                teamAPlayers = "\(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[0].player?.firstName?.prefix(1).capitalized ?? "")\(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[0].player?.lastName?.prefix(1).capitalized ?? "") & \(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[1].player?.firstName?.prefix(1).capitalized ?? "")\(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[1].player?.lastName?.prefix(1).capitalized ?? "")"
                
                teamBPlayers = "\(self.competitorArray.filter({$0.team_String == .teamB}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[0].player?.firstName?.prefix(1).capitalized ?? "")\(self.competitorArray.filter({$0.team_String == .teamB}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[0].player?.lastName?.prefix(1).capitalized ?? "") & \(self.competitorArray.filter({$0.team_String == .teamB}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[1].player?.firstName?.prefix(1).capitalized ?? "")\(self.competitorArray.filter({$0.team_String == .teamB}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[1].player?.lastName?.prefix(1).capitalized ?? "")"
            default://poss 3 players for six point game
                break
            }
        }
        if currentGF.assignShotsRecd == .TeamsAB {
            switch currentGF.noOfPlayersNeeded {
            case 4:
                teamAPlayers = "\(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[0].player?.firstName?.prefix(1).capitalized ?? "")\(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[0].player?.lastName?.prefix(1).capitalized ?? "") & \(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[1].player?.firstName?.prefix(1).capitalized ?? "")\(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[1].player?.lastName?.prefix(1).capitalized ?? "")"
                
                teamBPlayers = "\(self.competitorArray.filter({$0.team_String == .teamB}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[0].player?.firstName?.prefix(1).capitalized ?? "")\(self.competitorArray.filter({$0.team_String == .teamB}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[0].player?.lastName?.prefix(1).capitalized ?? "") & \(self.competitorArray.filter({$0.team_String == .teamB}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[1].player?.firstName?.prefix(1).capitalized ?? "")\(self.competitorArray.filter({$0.team_String == .teamB}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[1].player?.lastName?.prefix(1).capitalized ?? "")"
            case 2:
                teamAPlayers = "\(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[0].player?.firstName?.prefix(1).capitalized ?? "")\(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[0].player?.lastName?.prefix(1).capitalized ?? "") & \(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[1].player?.firstName?.prefix(1).capitalized ?? "")\(self.competitorArray.filter({$0.team_String == .teamA}).sorted(by: {$0.firstName ?? "" < $1.firstName ?? ""})[1].player?.lastName?.prefix(1).capitalized ?? "")"
                
            default:
                break
            }
            
        }
        
        
        
        
        
        
        
        
        
        // results when game still in play ie not at dormie or won/lost
        
        if currentMatchScore >= 0 && currentMatchScore < holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) < holesRemaining {
            
            switch currentMatchScore {
            case 0:
                result = "All square"
                
            case _ where currentMatchScore > 0:
                switch currentGF.assignTeamGrouping{
                case .Indiv:
                    // six point game
                    break
                    
                case .TeamsAB:
                    switch currentGF.assignShotsRecd{
                    case .Indiv:
                        switch currentGF.noOfPlayersNeeded{
                        case 2://singles
                            result = "\(playerA) \(currentMatchScore) UP"
                        default://4BBB
                            result = "\(teamAPlayers) \(currentMatchScore) UP"
                        }
                    case .TeamsAB://foursomes
                        result = "\(teamAPlayers) \(currentMatchScore) UP"
                    case .TeamC:
                        break
                        
                        
                    }
                case .TeamC:
                    break
                }
                
            case _ where currentMatchScore < 0:
                switch currentGF.assignTeamGrouping{
                case .Indiv:
                    // six point game
                    break
                    
                case .TeamsAB:
                    switch currentGF.assignShotsRecd{
                    case .Indiv:
                        switch currentGF.noOfPlayersNeeded{
                        case 2://singles
                            result = "\(playerB) \(-currentMatchScore) UP"
                        default://4BBB
                            result = "\(teamBPlayers) \(-currentMatchScore) UP"
                        }
                    case .TeamsAB://foursomes
                        result = "\(teamBPlayers) \(-currentMatchScore) UP"
                    case .TeamC:
                        break
                    }
                case .TeamC:
                    break
                }
                
            default:
                break
                
            }
        }
        
        // results when game at dormie
        if currentMatchScore >= 0 && currentMatchScore == holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) == holesRemaining {
            holesRemainingString = ""
            switch currentMatchScore {
            case 0:
                result = "Match halved"
                
            case _ where currentMatchScore > 0:
                switch currentGF.assignTeamGrouping{
                case .Indiv:
                    // six point game
                    break
                    
                case .TeamsAB:
                    switch currentGF.assignShotsRecd{
                    case .Indiv:
                        switch currentGF.noOfPlayersNeeded{
                        case 2://singles
                            
                            
                            result = "\(playerA) DORMIE \(currentMatchScore) UP"
                        default://4BBB
                            result = "\(teamAPlayers) DORMIE \(currentMatchScore) UP"
                        }
                    case .TeamsAB://foursomes
                        result = "\(teamAPlayers) \(currentMatchScore) UP"
                    case .TeamC:
                        break
                        
                        
                    }
                case .TeamC:
                    break
                }
                
            case _ where currentMatchScore < 0:
                switch currentGF.assignTeamGrouping{
                case .Indiv:
                    // six point game
                    break
                    
                case .TeamsAB:
                    switch currentGF.assignShotsRecd{
                    case .Indiv:
                        switch currentGF.noOfPlayersNeeded{
                        case 2://singles
                            
                            result = "\(playerB) DORMIE \(-currentMatchScore) UP"
                        default://4BBB
                            result = "\(teamBPlayers) DORMIE \(-currentMatchScore) UP"
                        }
                    case .TeamsAB://foursomes
                        result = "\(teamBPlayers) DORMIE \(-currentMatchScore) UP"
                    case .TeamC:
                        break
                    }
                case .TeamC:
                    break
                }
                
            default:
                break
                
                
                
            }
        }
        
        
        //results when game won or lost
        if currentMatchScore >= 0 && currentMatchScore > holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) > holesRemaining {
            holesRemainingString = ""
            switch currentMatchScore {
                
            case _ where currentMatchScore > 0:
                switch currentGF.assignTeamGrouping{
                case .Indiv:
                    // six point game
                    break
                    
                case .TeamsAB:
                    switch currentGF.assignShotsRecd{
                    case .Indiv:
                        switch currentGF.noOfPlayersNeeded{
                        case 2://singles
                            if holesRemaining != 0 {
                                result = "\(playerA) WON \(currentMatchScore) & \(holesRemaining)"
                                
                            } else {
                                result = "\(playerA) WON \(currentMatchScore) UP"
                                
                            }
                        default: //4BBB
                            if holesRemaining != 0 {
                                result = "\(teamAPlayers) WON \(currentMatchScore) & \(holesRemaining)"
                                
                            } else {
                                result = "\(teamAPlayers) WON \(currentMatchScore) UP"
                                
                            }
                        }
                    case .TeamsAB://foursomes
                        if holesRemaining != 0 {
                            result = "\(teamAPlayers) WON \(currentMatchScore) & \(holesRemaining)"
                            
                        } else {
                            result = "\(teamAPlayers) WON \(currentMatchScore) UP"
                            
                        }
                    case .TeamC:
                        break
                    }
                case .TeamC:
                    break
                }
                
                
                
            case _ where currentMatchScore < 0:
                switch currentGF.assignTeamGrouping{
                case .Indiv:
                    // six point game
                    break
                    
                case .TeamsAB:
                    switch currentGF.assignShotsRecd{
                    case .Indiv:
                        switch currentGF.noOfPlayersNeeded{
                        case 2://singles
                            if holesRemaining != 0 {
                                result = "\(playerB) WON \(-currentMatchScore) & \(holesRemaining)"
                                
                            } else {
                                result = "\(playerB) WON \(-currentMatchScore) UP"
                                
                            }
                        default: //4BBB
                            if holesRemaining != 0 {
                                result = "\(teamBPlayers) WON \(-currentMatchScore) & \(holesRemaining)"
                                
                            } else {
                                result = "\(teamBPlayers) WON \(-currentMatchScore) UP"
                                
                            }
                        }
                        
                    case .TeamsAB://foursomes
                        if holesRemaining != 0 {
                            result = "\(teamBPlayers) WON \(-currentMatchScore) & \(holesRemaining)"
                            
                        } else {
                            result = "\(teamBPlayers) WON \(-currentMatchScore) UP"
                            
                        }
                    case .TeamC:
                        break
                    }
                    
                    
                    
                    
                case .TeamC:
                    break
                }
                
                
                
                
            default:
                break
                
            }
        }
        
        
        
        return (result,holesRemainingString)
    }
    
    //3 Func to return the 1UP, A/S, UP for match score on hole by hole basis. 4th string is for Color. this needs work still!! loop on holesPlayed
    func CurrentMatchScoreByHoleString(currentMatchScore: Int, holesPlayed: Int, currentGF: CurrentGameFormat) -> (String, String, String, String){
        // results when game still in play ie not at dormie or won/lost
        
        
        
        
        
        
        
        let holesRemaining = 18 - holesPlayed
        
        
        var result0 = ""
        var result1 = ""
        var result2 = ""
        //var result3 = ""
        var textColor = ""
        if currentMatchScore >= 0 && currentMatchScore < holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) < holesRemaining {
            
            
            switch currentMatchScore {
            case 0:
                result0 = ""
                result1 = "A/S"
                result2 = ""
                textColor = "green"
                //result[3] = holesRemainingString
            case _ where currentMatchScore > 0:
                // result[0] = "\(currentMatchScore) UP"
                result0 = "\(currentMatchScore) UP"
                result1 = ""
                result2 = ""
                textColor = "red"
                
                
                //result[3] = holesRemainingString
            case _ where currentMatchScore < 0:
                result2 = "\(-currentMatchScore) UP"
                result0 = ""
                result1 = ""
                textColor = "blue"
                //result[3] = holesRemainingString
            default:
                result0 = ""
                result1 = ""
                result2 = ""
                textColor = "green"
            }
            
        }
        // results when game at dormie
        if currentMatchScore >= 0 && currentMatchScore == holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) == holesRemaining {
            switch currentMatchScore {
            case 0:
                result0 = "Match halved"
                result1 = ""
                result2 = ""
                textColor = "green"
                
            case _ where currentMatchScore > 0:
                result0 = "Team A DORMIE \(currentMatchScore) UP"
                result1 = ""
                result2 = ""
                textColor = "green"
            case _ where currentMatchScore < 0:
                result0 = "Team B  DORMIE \(-currentMatchScore) UP"
                result1 = ""
                result2 = ""
                textColor = "green"
            default:
                result0 = ""
                result1 = ""
                result2 = ""
                textColor = "green"
                
            }
        }
        //results when game won or lost WILL NEED TO AMEND TO SWITCH BETWEEN TEAMS AND PLAYERS 4BALL AND 2 BALL
        
        if currentMatchScore >= 0 && currentMatchScore > holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) > holesRemaining {
            switch currentMatchScore {
            case _ where currentMatchScore > 0:
                if holesRemaining != 0 {
                    result0 = "Team A WON \(currentMatchScore) & \(holesRemaining)"
                    result1 = ""
                    result2 = ""
                    textColor = "green"
                } else {
                    result0 = "Team A WON \(currentMatchScore) UP"
                    result1 = ""
                    result2 = ""
                    textColor = "green"
                }
            case _ where currentMatchScore < 0:
                if holesRemaining != 0 {
                    result0 = "Team B WON \(-currentMatchScore) & \(holesRemaining)"
                    result1 = ""
                    result2 = ""
                    textColor = "green"
                } else {
                    result0 = "Team B WON \(-currentMatchScore) UP"
                    result1 = ""
                    result2 = ""
                    textColor = "green"
                }
            default:
                result0 = ""
                result1 = ""
                result2 = ""
                textColor = "green"
                
            }
        }
        return (result0, result1, result2, textColor)
    }
 
    
    func SixPointString(currentGF: CurrentGameFormat, holeIndex: Int) -> [String] {
        
        let sixPointGrossScores_CompetitorA = self.SortedCompetitors(currentGF: currentGF)[0].competitorScoresArray
        let sixPointGrossScores_CompetitorB = self.SortedCompetitors(currentGF: currentGF)[1].competitorScoresArray
        let sixPointGrossScores_CompetitorC = self.SortedCompetitors(currentGF: currentGF)[2].competitorScoresArray
        var holesPlayed = 0
        var netScores = [0,0,0]
      
        var totalPoints = [0,0,0]
        var holePoints: [[Int]] = Array(repeating: [0,0,0], count: 18)
        
        for j in 0..<18 {
            
            switch self.AllScoresCommitted(holeIndex: j){
            case true:
                holesPlayed += 1
                
                // create a netScores array with the three players
                netScores[0] = Int(sixPointGrossScores_CompetitorA[j].NetScoreMatch())
                netScores[1] = Int(sixPointGrossScores_CompetitorB[j].NetScoreMatch())
                netScores[2] = Int(sixPointGrossScores_CompetitorC[j].NetScoreMatch())
                
                let lowestNetScore = netScores.min()
                let highestNetScore = netScores.max()
                
                if lowestNetScore == highestNetScore {
                    //totalPoints = [2,2,2]
                    for i in 0..<3 {
                        totalPoints[i] += 2
                        holePoints[j][i] = 2
                        
                    }
                    
                    
                } else {// if not all equal points then calculate for EACH player whether score is MIN or MAX and how many other MIN or MAX
                
                        
                // calculate count of highest and lowest scores
                var highestNetScoreCount = 0
                var lowestNetScoreCount = 0
                      
                        netScores.forEach{
                            compScore in if compScore == highestNetScore {highestNetScoreCount += 1}
                        }
                        netScores.forEach{
                            compScore in if compScore == lowestNetScore {lowestNetScoreCount += 1}
                        }
                        
                        for i in 0..<3 {
                            if netScores[i] == highestNetScore {
                                switch highestNetScoreCount {
                                case 1:
                                    totalPoints[i] += 0
                                    holePoints[j][i] = 0
                                default:// only other possible value is 2 (cannot be zero and if 3 would have been diverted in first part of IF statement
                                    totalPoints[i] += 1
                                    holePoints[j][i] = 1
                                }
                            }
                            if netScores[i] == lowestNetScore {
                                switch lowestNetScoreCount {
                                case 1:
                                    totalPoints[i] += 4
                                    holePoints[j][i] = 4
                                default:
                                    totalPoints[i] += 3
                                    holePoints[j][i] = 3
                                }
                            }
                            if netScores[i] != lowestNetScore && netScores[i] != highestNetScore {
                                totalPoints[i] += 2
                                holePoints[j][i] = 2
                            }
                          
                        }
                        
                 }
      
            case false:
                break
            }
        } //for each loop
        
        let holesRemaining = 18 - holesPlayed
        let holesRemainingString = "\(holesRemaining) holes remaining"
        
        let lowPoints = totalPoints.min() ?? 0
        
        var player1NetPoints: String = "0"
        var player2NetPoints: String = "0"
        var player3NetPoints: String = "0"
        
//        var player1TotalPoints: String = ""
//        var player2TotalPoints: String = ""
//        var player3TotalPoints: String = ""
        
        
        if totalPoints[0] - lowPoints != 0 {
            player1NetPoints = String(totalPoints[0] - lowPoints)
        } else {
            player1NetPoints = "zip"
        }
        
        if totalPoints[1] - lowPoints != 0 {
            player2NetPoints = String(totalPoints[1] - lowPoints)
        } else {
            player2NetPoints = "zip"
        }
        
        if totalPoints[2] - lowPoints != 0 {
            player3NetPoints = String(totalPoints[2] - lowPoints)
        } else {
            player3NetPoints = "zip"
        }
        
        
        
//        player1TotalPoints
//
//
//        switch Int(player1NetPoints){
//        case _ where Int(player1NetPoints) ?? 0 == 0:
//            player1TotalPoints =  "\(player1NetPoints)     (\(totalPoints[0]))"
//        case 1:
//            player1TotalPoints =  "\(player1NetPoints) pt  (\(totalPoints[0]))"
//        default:
//            player1TotalPoints =  "\(player1NetPoints) pts (\(totalPoints[0]))"
//        }
//
//        switch Int(player2NetPoints){
//        case _ where Int(player2NetPoints) ?? 0 == 0:
//            player2TotalPoints =  "\(player2NetPoints)     (\(totalPoints[1]))"
//        case 1:
//            player2TotalPoints =  "\(player2NetPoints) pt  (\(totalPoints[1]))"
//        default:
//            player2TotalPoints =  "\(player2NetPoints) pts (\(totalPoints[1]))"
//        }
//
//        switch Int(player3NetPoints){
//        case _ where Int(player3NetPoints) ?? 0 == 0:
//            player3TotalPoints =  "\(player3NetPoints)     (\(totalPoints[2]))"
//        case 1:
//            player3TotalPoints =  "\(player3NetPoints) pt  (\(totalPoints[2]))"
//        default:
//            player3TotalPoints =  "\(player3NetPoints) pts (\(totalPoints[2]))"
//        }
        
   
       
        
        return [String(totalPoints[0]), String(totalPoints[1]), String(totalPoints[2]), holesRemainingString, String(holePoints[holeIndex][0]),String(holePoints[holeIndex][1]), String(holePoints[holeIndex][2]), String(player1NetPoints), String(player2NetPoints), String(player3NetPoints)]
    }// sixpoint func
    
    
    
    
    
    
}

extension Game {
    func LowScoreByHole4BBB (holeIndex: Int) -> Int16 {
        var lowScore: Int16 = 0
        var scores: [Int16] = []
        
        for competitor in self.competitorArray{
            if competitor.competitorScoresArray[holeIndex].NetScoreMatch() != 0{
                scores.append(competitor.competitorScoresArray[holeIndex].NetScoreMatch())
            }
        }
        lowScore = scores.min() ?? 0
        
        
        return lowScore
    }
}






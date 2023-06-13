//
//  File.swift
//  testtest
//
//  Created by Philip Nye on 09/04/2023.
//

import Foundation


class CurrentGameFormat: ObservableObject {
    @Published var id: Int = 99
    @Published var format: GameFormatName = GameFormatName.fourBallBBMatch
    @Published var description: String = ""
    @Published var noOfPlayersNeeded: Int = 0
    @Published var playerHandAllowances: [Double] = []
    @Published var assignShotsRecd: Assignment = Assignment.Indiv
    @Published var assignTeamGrouping: Assignment = Assignment.Indiv
    @Published var competitorSort: Assignment = Assignment.Indiv
    @Published var playFormat: PlayFormat = PlayFormat.strokeplay
    @Published var extraShotsTeamAdj: Double = 1.0
    @Published var stableford: Bool = false
    @Published var medal: Bool = true
    @Published var bogey: Bool = false
   
    
    //variables to be used briefly in game creation
    @Published var swipedCompetitor: Competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext)).competitor
}


enum GameDuration: Int, CaseIterable {
    case H9 = 0
    case H18 = 1
    func stringValue() -> String {
        switch (self){
        case .H9:
            return "9 holes"
        case .H18:
            return "18 holes"
        }
    }
}

enum DistMetric: Int, CaseIterable {
    case yards = 0
    case metres = 1
    
    func stringValue() -> String{
        switch(self){
        case .yards:
            return "yards"
        case .metres:
            return "metres"
        }
    }
    func stringValueInitial() -> String{
        switch(self){
        case .yards:
            return "y"
        case .metres:
            return "m"
        }
    }
    
}


enum ScoreFormat: Int, CaseIterable {
    case medal = 0
    case stableford = 1
    case bogey = 2
    
    func stringValue() -> String{
        switch(self){
        case .medal:
            return "Medal"
        case .stableford:
            return "Stableford"
        case .bogey:
            return "Bogey"
        }
    }
}

enum HandicapFormat: Int, CaseIterable {
    case handicap = 0
    case scratch = 1
    
    func stringValue() -> String {
        switch(self){
        case .handicap:
            return "Handicap"
        case .scratch:
            return "Scratch"
        }
    }
}


enum PlayFormat: Int, CaseIterable, Codable {
    case strokeplay = 0
    case matchplay = 1
    
    func stringValue() -> String {
        switch(self){
        case .strokeplay:
            return "Strokeplay"
        case .matchplay:
            return "Matchplay"
        }
    }
}

enum TeamAssignment: Int, CaseIterable {
    case indiv = 0
    case teamA = 1
    case teamB = 2
    case teamC = 3
    func stringValue() -> String {
        switch(self){
        case.indiv:
            return "Individual"
        case.teamA:
            return "Team A"
        case .teamB:
            return "Team B"
        case .teamC:
            return "Team C"
        }
    }
    
    func stringValueInitial() -> String {
        switch(self){
        case.indiv:
            return "I"
        case.teamA:
            return "A"
        case .teamB:
            return "B"
        case .teamC:
            return "C"
        }
    }
}


enum Assignment: String , Codable, Equatable {
    case Indiv = "Individual"
    case TeamsAB = "Teams A and B"
    case TeamC = "Team C"
    
}
enum CompetitorSort: String, Codable, Equatable {
    case none = "None"
    case teamAB = "Teams A & B"
    case teamC = "Team C"
   
}


struct GameFormat: Identifiable, Hashable, Equatable, Codable {
    var id: Int
    var format: GameFormatName = GameFormatName.fourBallBBMatch
    var description: String
    var noOfPlayersNeeded: Int
    var playerHandAllowances: [Double] = []
    var assignShotsRecd: Assignment = Assignment.Indiv
    var assignTeamGrouping: Assignment = Assignment.Indiv
    var competitorSort: Assignment = Assignment.Indiv
    var playFormat: PlayFormat = PlayFormat.strokeplay
    var extraShotsTeamAdj: Double = 1.0
    var stableford: Bool
    var medal: Bool
    var bogey: Bool
    
}
var gameFormat0 = GameFormat(id: 0, format: GameFormatName.fourBallBBStroke,description: "Each team uses the best score from their pairing", noOfPlayersNeeded: 4,  playerHandAllowances: [0.9, 0.9, 0.9, 0.9],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .Indiv,playFormat: .strokeplay, extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat1 = GameFormat(id: 1, format: GameFormatName.fourBallBBMatch,description: "Each team uses the best score from their pairing", noOfPlayersNeeded: 4,  playerHandAllowances: [0.9, 0.9, 0.9, 0.9],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .Indiv,playFormat: .matchplay, extraShotsTeamAdj: 1.0, stableford: false, medal: true, bogey: false)

var gameFormat2 = GameFormat(id: 2, format: GameFormatName.fourBallCombinedStroke, description: "Each team uses the combined score from their pairing", noOfPlayersNeeded: 4, playerHandAllowances: [1,1,1,1],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)



var gameFormat3 = GameFormat(id: 3, format: GameFormatName.fourBallCombinedMatch, description: "Each team uses the combined score from their pairing", noOfPlayersNeeded: 4, playerHandAllowances: [1,1,1,1],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .Indiv,playFormat: .matchplay,  extraShotsTeamAdj: 1.0, stableford: false, medal: true, bogey: false)

var gameFormat4 = GameFormat(id: 4,format: GameFormatName.fourSomesStroke , description: "Two teams of two playing with one ball per team. Alternate the shots between the players", noOfPlayersNeeded: 4,  playerHandAllowances: [0.5,0.5,0.5,0.5],assignShotsRecd: Assignment.TeamsAB ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 0.5, stableford: true, medal: true, bogey: true)

var gameFormat5 = GameFormat(id: 5,format: GameFormatName.fourSomesMatch , description: "Two teams of two playing with one ball per team. Alternate the shots between the players", noOfPlayersNeeded: 4,  playerHandAllowances: [0.5,0.5,0.5,0.5],assignShotsRecd: Assignment.TeamsAB ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .Indiv,playFormat: .matchplay,  extraShotsTeamAdj: 0.5, stableford: false, medal: true, bogey: false)

var gameFormat6 = GameFormat(id: 6,format: GameFormatName.greenSomesStroke, description: "Two teams of two playing with one ball per team. Alternate the shots between the players, after ALL players have teed off", noOfPlayersNeeded: 4,  playerHandAllowances: [0.6,0.4,0.6,0.4],assignShotsRecd: Assignment.TeamsAB ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .TeamsAB,playFormat: .strokeplay,  extraShotsTeamAdj: 0.5, stableford: true, medal: true, bogey: true)

var gameFormat7 = GameFormat(id: 7,format: GameFormatName.greenSomesMatch, description: "Two teams of two playing with one ball per team. Alternate the shots between the players, after ALL players have teed off", noOfPlayersNeeded: 4,  playerHandAllowances: [0.6,0.4,0.6,0.4],assignShotsRecd: Assignment.TeamsAB ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .TeamsAB,playFormat: .matchplay,  extraShotsTeamAdj: 0.5, stableford: false, medal: true, bogey: false)

var gameFormat8 = GameFormat(id: 8,format: GameFormatName.sixPoint , description: "A game for three players, every hole is worth 6 points", noOfPlayersNeeded: 3,  playerHandAllowances: [0.9,0.9,0.9],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.Indiv,competitorSort: .Indiv,playFormat: .matchplay,  extraShotsTeamAdj: 1.0, stableford: false, medal: true, bogey: false)

var gameFormat9 = GameFormat(id: 9, format: GameFormatName.twoPlayScramble,description: "All players tee off and then all players play from the selected best shot, and repeat until holed out", noOfPlayersNeeded: 2,  playerHandAllowances: [0.35,0.15],assignShotsRecd: Assignment.TeamC ,assignTeamGrouping: Assignment.TeamC,competitorSort: .TeamC,playFormat: .strokeplay,  extraShotsTeamAdj: 0.5, stableford: false, medal: true, bogey: false)

var gameFormat10 = GameFormat(id: 10, format: GameFormatName.threePlayScramble, description: "All players tee off and then all players play from the selected best shot, and repeat until holed out", noOfPlayersNeeded: 3,  playerHandAllowances: [0.3,0.175,0.125],assignShotsRecd: Assignment.TeamC ,assignTeamGrouping: Assignment.TeamC,competitorSort: .TeamC,playFormat: .strokeplay,  extraShotsTeamAdj: 0.3333333, stableford: false, medal: true, bogey: false)

var gameFormat11 = GameFormat(id: 11, format: GameFormatName.fourPlayScramble,description: "All players tee off and then all players play from the selected best shot, and repeat until holed out", noOfPlayersNeeded: 4,  playerHandAllowances: [0.25,0.2,0.15,0.1],assignShotsRecd: Assignment.TeamC ,assignTeamGrouping: Assignment.TeamC,competitorSort: .TeamC,playFormat: .strokeplay,  extraShotsTeamAdj: 0.25, stableford: false, medal: true, bogey: false)

var gameFormat12 = GameFormat(id: 12, format: GameFormatName.twoVtwoscramble,description: "Two teams of two have a matchplay event, using their respective texas scramble scores on each hole", noOfPlayersNeeded: 4,  playerHandAllowances: [0.35,0.15,0.35,0.15],assignShotsRecd: Assignment.TeamsAB ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .TeamsAB,playFormat: .matchplay,  extraShotsTeamAdj: 0.5, stableford: false, medal: true, bogey: false)

var gameFormat13 = GameFormat(id: 13, format: GameFormatName.noneOnePlayer,description: "No particular game being played - player will record score in either medal, stableford or bogey format", noOfPlayersNeeded: 1,  playerHandAllowances: [0.95],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.Indiv,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford:true, medal: true, bogey: true)

var gameFormat14 = GameFormat(id: 14, format: GameFormatName.noneTwoPlayer,description: "No particular game being played - players will record their scores in either medal, stableford or bogey format", noOfPlayersNeeded: 2, playerHandAllowances: [0.95,0.95],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.Indiv,competitorSort: .Indiv,playFormat: .strokeplay, extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat15 = GameFormat(id: 15, format: GameFormatName.noneThreePlayer,description: "No particular game being played - players will record their scores in either medal, stableford or bogey format", noOfPlayersNeeded: 3,  playerHandAllowances: [0.95,0.95,0.95],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.Indiv,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat16 = GameFormat(id: 16, format: GameFormatName.noneFourPlayer,description: "No particular game being played - players will record their scores in either medal, stableford or bogey format", noOfPlayersNeeded: 4,  playerHandAllowances: [0.95,0.95,0.95,0.95],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.Indiv,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat17 = GameFormat(id: 17, format: GameFormatName.singlesMatchplay, description: "A head to head with two players", noOfPlayersNeeded: 2,  playerHandAllowances: [1,1],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .Indiv,playFormat: .matchplay,  extraShotsTeamAdj: 1.0, stableford: false, medal: true, bogey: false)

var gameFormat18 = GameFormat(id: 18, format: GameFormatName.twoPlaySkins,description: "If a hole is halved the point is rolled over to the next hole", noOfPlayersNeeded: 2,  playerHandAllowances: [1,1],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.Indiv,competitorSort: .Indiv,playFormat: .matchplay,  extraShotsTeamAdj: 1.0, stableford: false, medal: true, bogey: false)

var gameFormat19 = GameFormat(id: 19, format: GameFormatName.threePlaySkins,description: "If a hole is halved the point is rolled over to the next hole", noOfPlayersNeeded: 3, playerHandAllowances: [1,1,1], assignShotsRecd: Assignment.Indiv,assignTeamGrouping: Assignment.Indiv,competitorSort: .Indiv,playFormat: .matchplay, extraShotsTeamAdj: 1.0, stableford: false, medal: true, bogey: false)

var gameFormat20 = GameFormat(id: 20, format: GameFormatName.fourPlaySkins, description: "If a hole is halved the point is rolled over to the next hole", noOfPlayersNeeded: 4, playerHandAllowances: [1,1,1,1],assignShotsRecd: Assignment.Indiv,assignTeamGrouping: Assignment.Indiv, competitorSort: .Indiv,playFormat: .matchplay,  extraShotsTeamAdj: 1.0, stableford: false, medal: true, bogey: false)

var gameFormat21 = GameFormat(id: 21, format: GameFormatName.best1of4,description: "All four players as 1 team. Take the best 1 score from the 4 as the team score on each hole", noOfPlayersNeeded: 4,  playerHandAllowances: [0.75, 0.75, 0.75, 0.75],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamC,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat22 = GameFormat(id: 22, format: GameFormatName.best2of4,description: "All four players as 1 team. Take the best 2 scores from the 4 as the team score on each hole", noOfPlayersNeeded: 4,  playerHandAllowances: [0.8,0.8,0.8,0.8],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamC,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat23 = GameFormat(id: 23, format: GameFormatName.best3of4,description: "All four players as 1 team. Take the best 3 scores from the 4 as the team score on each hole", noOfPlayersNeeded: 4,  playerHandAllowances: [1,1,1,1],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamC,competitorSort: .Indiv,playFormat: .strokeplay, extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat24 = GameFormat(id: 24, format: GameFormatName.best4of4,description: "All four players as 1 team. Take all the scores from the 4 as the team score on each hole", noOfPlayersNeeded: 4,  playerHandAllowances: [1,1,1,1],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamC,competitorSort: .Indiv,playFormat: .strokeplay, extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat25 = GameFormat(id: 25, format: GameFormatName.best1of3,description: "All three players as 1 team. Take the best 1 score from the 3 as the team score on each hole", noOfPlayersNeeded: 3,  playerHandAllowances: [0.70, 0.70, 0.70],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamC,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat26 = GameFormat(id: 26, format: GameFormatName.best2of3,description: "All three players as 1 team. Take the best 2 scores from the 3 as the team score on each hole", noOfPlayersNeeded: 3,  playerHandAllowances: [0.85,0.85,0.85],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamC,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat27 = GameFormat(id: 27, format: GameFormatName.best3of3,description: "All three players as 1 team. Take all three score as the team score on each hole", noOfPlayersNeeded: 3,  playerHandAllowances: [1,1,1],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamC,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat28 = GameFormat(id: 28, format: GameFormatName.pinehurstChapmanStroke, description: "To be clarified", noOfPlayersNeeded: 4, playerHandAllowances: [0.6,0.4,0.6,0.4],assignShotsRecd: Assignment.TeamsAB ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .TeamsAB,playFormat: .strokeplay,  extraShotsTeamAdj: 0.5, stableford: true, medal: true, bogey: true)

var gameFormat29 = GameFormat(id: 29, format: GameFormatName.pinehurstChapmanMatch, description: "To be clarified", noOfPlayersNeeded: 4, playerHandAllowances: [0.6,0.4,0.6,0.4],assignShotsRecd: Assignment.TeamsAB ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .TeamsAB,playFormat: .matchplay,  extraShotsTeamAdj: 0.5, stableford: false, medal: true, bogey: false)


var gameFormat30 = GameFormat(id: 30, format: GameFormatName.fourBallBB2P,description: "Each team uses the best score from their pairing", noOfPlayersNeeded: 2,  playerHandAllowances: [0.9, 0.9],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat31 = GameFormat(id: 31, format: GameFormatName.fourBallCombined2P, description: "Each team uses the combined score from their pairing", noOfPlayersNeeded: 2, playerHandAllowances: [1,1],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 1.0, stableford: true, medal: true, bogey: true)

var gameFormat32 = GameFormat(id: 32,format: GameFormatName.fourSomes2P , description: "A team of two playing with one ball per team. Alternate the shots between the players", noOfPlayersNeeded: 2,  playerHandAllowances: [0.5,0.5],assignShotsRecd: Assignment.TeamsAB ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 0.5, stableford: true, medal: true, bogey: true)

var gameFormat33 = GameFormat(id: 33,format: GameFormatName.greenSomes2P, description: "A team of two playing with one ball per team. Alternate the shots between the players, after ALL players have teed off", noOfPlayersNeeded: 2,  playerHandAllowances: [0.6,0.4],assignShotsRecd: Assignment.TeamsAB ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .TeamsAB,playFormat: .strokeplay,  extraShotsTeamAdj: 0.5, stableford: true, medal: true, bogey: true)

var gameFormat34 = GameFormat(id: 34, format: GameFormatName.pinehurstChapman2P, description: "To be clarified", noOfPlayersNeeded: 2,  playerHandAllowances: [0.6,0.4],assignShotsRecd: Assignment.TeamsAB ,assignTeamGrouping: Assignment.TeamsAB,competitorSort: .TeamsAB,playFormat: .strokeplay,  extraShotsTeamAdj: 0.5, stableford: true, medal: true, bogey: true)

var gameFormat35 = GameFormat(id: 35, format: GameFormatName.noFormat, description: "No format selected", noOfPlayersNeeded: 2,  playerHandAllowances: [1,1],assignShotsRecd: Assignment.Indiv ,assignTeamGrouping: Assignment.Indiv,competitorSort: .Indiv,playFormat: .strokeplay,  extraShotsTeamAdj: 0.0, stableford: true, medal: true, bogey: true)








enum GameFormatType: Int, CaseIterable {
    case fourBallBBStroke = 0
    case fourBallBBMatch = 1
    case fourBallCombinedStroke = 2
    case fourBallCombinedMatch = 3
    case fourSomesStroke = 4
    case fourSomesMatch = 5
    case greenSomesStroke = 6
    case greenSomesMatch = 7
    case sixPoint = 8
    case twoPlayScramble = 9
    case threePlayScramble = 10
    case fourPlayScramble = 11
    case twoVtwoscramble = 12
    case noneOnePlayer = 13
    case noneTwoPlayer = 14
    case noneThreePlayer = 15
    case noneFourPlayer = 16
    case singlesMatchplay = 17
    case twoPlaySkins = 18
    case threePlaySkins = 19
    case fourPlaySkins = 20
    case best1of4 = 21
    case best2of4 = 22
    case best3of4 = 23
    case best4of4 = 24
    
    case best1of3 = 25
    case best2of3 = 26
    case best3of3 = 27
    
    case pinehurstChapmanStroke = 28
    case pinehurstChapmanMatch = 29
    
    
    case fourBallBB2P = 30
    case fourBallCombined2P = 31
    case fourSomes2P = 32
    case greenSomes2P = 33
    case pinehurstChapman2P = 34
    case noFormat = 35
    
    func stringValue() -> String {
        switch(self){
        case .fourBallBBStroke:
            return "4BBB - S/P"
        case .fourBallBBMatch:
            return "4BBB - M/P"
        case .fourBallCombinedStroke:
            return "4B comb - S/P"
        case .fourBallCombinedMatch:
            return "4B comb - M/P"
        case .fourSomesStroke:
            return "4somes - S/P"
        case .fourSomesMatch:
            return "4somes - M/P"
        case .greenSomesStroke:
            return "Greensomes - S/P"
        case .greenSomesMatch:
            return "Greensomes - M/P"
        case .sixPoint:
            return "6 point game"
        case .twoPlayScramble:
            return "Texas scr. - 2P"
        case .threePlayScramble:
            return "Texas scr. - 3P"
        case .fourPlayScramble:
            return "Texas scr. - 4P"
        case .twoVtwoscramble:
            return "2 v 2 texas scr."
        case .noneOnePlayer:
            return "Stroke play - 1P"
        case .noneTwoPlayer:
            return "Stroke play - 2P"
        case .noneThreePlayer:
            return "Stroke play - 3P"
        case .noneFourPlayer:
            return "Stroke play - 4P"
        case .singlesMatchplay:
            return "Singles M/P"
        case .twoPlaySkins:
            return "2 player skins"
        case .threePlaySkins:
            return "3 player skins"
        case .fourPlaySkins:
            return "4 player skins"
        case .noFormat:
            return "No format selected"
        case .best1of4:
            return "Best 1 of 4"
        case .best2of4:
            return "Best 2 of 4"
        case .best3of4:
            return "Best 3 of 4"
        case .best4of4:
            return "Best 4 of 4"
        case .pinehurstChapmanStroke:
            return "Pine/Chap - S/P"
        case .pinehurstChapmanMatch:
            return "Pine/ Chap - M/P"
        case .best1of3:
            return "Best 1 of 3"
        case .best2of3:
            return "Best 2 of 3"
        case .best3of3:
            return "Best 3 of 3"
        case .fourBallBB2P:
            return "4 BBB - 2P"
        case .fourBallCombined2P:
            return "4 ball comb - 2P"
        case .fourSomes2P:
            return "4somes - 2P"
        case .greenSomes2P:
            return "Greensomes - 2P"
        case .pinehurstChapman2P:
            return "Pine/Chap - 2P"
        }
    }
        func NoOfPlayers() -> Int {
            switch(self){
            case .fourBallBBStroke:
                return 4
            case .fourBallBBMatch:
                return 4
            case .fourBallCombinedStroke:
                return 4
            case .fourBallCombinedMatch:
                return 4
            case .fourSomesStroke:
                return 4
            case .fourSomesMatch:
                return 4
            case .greenSomesStroke:
                return 4
            case .greenSomesMatch:
                return 4
            case .sixPoint:
                return 3
            case .twoPlayScramble:
                return 2
            case .threePlayScramble:
                return 3
            case .fourPlayScramble:
                return 4
            case .twoVtwoscramble:
                return 4
            case .noneOnePlayer:
                return 1
            case .noneTwoPlayer:
                return 2
            case .noneThreePlayer:
                return 3
            case .noneFourPlayer:
                return 4
            case .singlesMatchplay:
                return 2
            case .twoPlaySkins:
                return 2
            case .threePlaySkins:
                return 3
            case .fourPlaySkins:
                return 4
            case .noFormat:
                return 0
            case .best1of4:
                return 4
            case .best2of4:
                return 4
            case .best3of4:
                return 4
            case .best4of4:
                return 4
            case .pinehurstChapmanStroke:
                return 4
            case .pinehurstChapmanMatch:
                return 4
            case .best1of3:
                return 3
            case .best2of3:
                return 3
            case .best3of3:
                return 3
            case .fourBallBB2P:
                return 2
            case .fourBallCombined2P:
                return 2
            case .fourSomes2P:
                return 2
            case .greenSomes2P:
                return 2
            case .pinehurstChapman2P:
                return 2
            }
        
    }
    func Succint_Description() -> String {
        //does not need to cover matchplay or strokeplay as covered elsewhere
        switch(self){
        case .fourBallBBStroke:
            return "4 ball better ball"
        case .fourBallBBMatch:
            return "4 ball better ball"
        case .fourBallCombinedStroke:
            return "4 ball combined score"
        case .fourBallCombinedMatch:
            return "4 ball combined score"
        case .fourSomesStroke:
            return "Foursomes"
        case .fourSomesMatch:
            return "Foursomes"
        case .greenSomesStroke:
            return "Greensomes"
        case .greenSomesMatch:
            return "Greensomes"
        case .sixPoint:
            return "Six point game"
        case .twoPlayScramble:
            return "2 player Texas Scramble"
        case .threePlayScramble:
            return "3 player Texas Scramble"
        case .fourPlayScramble:
            return "4 player Texas Scramble"
        case .twoVtwoscramble:
            return "2 v 2 Texas Scramble"
        case .noneOnePlayer:
            return "1 player - casual round"
        case .noneTwoPlayer:
            return "2 player - casual round"
        case .noneThreePlayer:
            return "3 player - casual round"
        case .noneFourPlayer:
            return "4 player - casual round"
        case .singlesMatchplay:
            return "Singles"
        case .twoPlaySkins:
            return "2 player Skins"
        case .threePlaySkins:
            return "3 player Skins"
        case .fourPlaySkins:
            return "4 player Skins"
        case .noFormat:
            return "no format"
        case .best1of4:
            return "Best 1 from 4"
        case .best2of4:
            return "Best 2 from 4"
        case .best3of4:
            return "Best 3 from 4"
        case .best4of4:
            return "Best 4 from 4"
        case .pinehurstChapmanStroke:
            return "Pinehurst/Chapman"
        case .pinehurstChapmanMatch:
            return "Pinehurst/Chapman"
        case .best1of3:
            return "Best 1 from 3"
        case .best2of3:
            return "Best 2 from 3"
        case .best3of3:
            return "Best 3 from 3"
        case .fourBallBB2P:
            return "4 ball better ball - 2 players"
        case .fourBallCombined2P:
            return "4 ball combined - 2 players"
        case .fourSomes2P:
            return "Foursomes - 2 players"
        case .greenSomes2P:
            return "Greensomes - 2 players"
        case .pinehurstChapman2P:
            return "Pinehurst/Chapman - 2 players"
        }
    
}
    
}


enum GameFormatName: String, Codable, Equatable {
    case fourBallBBStroke = "4BBB - S/P"
    case fourBallBBMatch = "4BBB - M/P"
    case fourBallCombinedStroke = "4B comb - S/P"
    case fourBallCombinedMatch = "4B comb - M/P"
    case fourSomesStroke = "4somes - S/P"
    case fourSomesMatch = "4somes - M/P"
    case greenSomesStroke = "Greensomes - S/P"
    case greenSomesMatch = "Greensomes - M/P"
    case sixPoint = "6 point game"
    case twoPlayScramble = "Texas scr. - 2P"
    case threePlayScramble = "Texas scr. - 3P"
    case fourPlayScramble = "Texas scr. - 4P"
    case twoVtwoscramble = "2 v 2 texas scr."
    case noneOnePlayer = "Stroke play - 1P"
    case noneTwoPlayer = "Stroke play - 2P"
    case noneThreePlayer = "Stroke play - 3P"
    case noneFourPlayer = "Stroke play - 4P"
    case singlesMatchplay = "Singles M/P"
    case twoPlaySkins = "2 player skins"
    case threePlaySkins = "3 player skins"
    case fourPlaySkins = "4 player skins"
    case noFormat = "No format selected"
    case best1of4 = "Best 1 of 4"
    case best2of4 = "Best 2 of 4"
    case best3of4 = "Best 3 of 4"
    case best4of4 = "Best 4 of 4"
    case pinehurstChapmanStroke = "Pine/Chap - S/P"
    case pinehurstChapmanMatch = "Pine/ Chap - M/P"
    case best1of3 = "Best 1 of 3"
    case best2of3 = "Best 2 of 3"
    case best3of3 = "Best 3 of 3"
    case fourBallBB2P = "4 BBB - 2P"
    case fourBallCombined2P = "4 ball comb - 2P"
    case fourSomes2P = "4somes - 2P"
    case greenSomes2P = "Greensomes - 2P"
    case pinehurstChapman2P = "Pine/Chap - 2P"
    
}


var gameFormats = [

gameFormat0,
gameFormat1,
gameFormat2,
gameFormat3,
gameFormat4,
gameFormat5,
gameFormat6,
gameFormat7,
gameFormat8,
gameFormat9,
gameFormat10,
gameFormat11,
gameFormat12,
gameFormat13,
gameFormat14,
gameFormat15,
gameFormat16,
gameFormat17,
gameFormat18,
gameFormat19,
gameFormat20,
gameFormat21,
gameFormat22,
gameFormat23,
gameFormat24,
gameFormat25,
gameFormat26,
gameFormat27,
gameFormat28,
gameFormat29,
gameFormat30,
gameFormat31,
gameFormat32,
gameFormat33,
gameFormat34,
gameFormat35
]

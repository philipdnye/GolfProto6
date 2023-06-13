//
//  AddGameViewModel.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import Foundation
import SwiftUI

enum AddGameViewFocusable: Hashable {
    case name
    case date
    case club
    case course
    case teebox
}



class AddGameViewModel: ObservableObject {

    @StateObject private var playerListVM = PlayerListViewModel()
    @StateObject private var clubListVM = ClubListViewModel()
    @EnvironmentObject var currentGF: CurrentGameFormat
    @StateObject private var gameListVM = GameListViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var name: String = ""
    var date: Date = Date()
    var teeBox: TeeBox = TeeBox()
    var selectedPlayers: [PlayerViewModel] = []

    @Published var pickedClub: Int = 0
    @Published var pickedCourse: Int = 0
    @Published var pickedTeeBox: Int = 0
    
    
    
    
    @Published var pickerScoringFormat: ScoreFormat = .medal
    @Published var pickerHandicapFormat: HandicapFormat = .handicap

    @Published var pickerGameFormat: GameFormatType = .fourBallBBMatch

    @Published var pickerStartingHole: Int = 1
    @Published var pickerGameDuration: Int = 1
    
    
    
    @Published var newTeeBox: TeeBox = TeeBox()
    
    @Published var newTeeBoxForGame: TeeBox = TeeBox()
    
    func AssignHandicapsAndShots(game: Game, currentGF: CurrentGameFormat) {
        AssignPlayingHandicaps(game: game, currentGF: currentGF)
        AssignTeamPlayingHandicap(game: game, currentGF: currentGF)
        AssignExtraShots(game: game, currentGF: currentGF)
        AssignTeamExtraShots(game: game, currentGF: currentGF)
        AssignShotsReceived(game: game, currentGF: currentGF)
        let manager = CoreDataManager.shared
        manager.save()
    }
    

    func AssignCompetitorTeams(game: Game, currentGF: CurrentGameFormat) {
        switch currentGF.assignTeamGrouping {
        case .Indiv:
            for i in 0..<(game.competitorArray.count) {
                game.competitorArray[i].team = Int16(TeamAssignment.indiv.rawValue)
            }
        case .TeamsAB:
            switch currentGF.noOfPlayersNeeded {
            case 4:
                for i in 0..<(game.competitorArray.count) {
                    switch i {
                    case 0:
                        game.competitorArray[i].team = Int16(TeamAssignment.teamA.rawValue)
                    case 1:
                        game.competitorArray[i].team = Int16(TeamAssignment.teamA.rawValue)
                    case 2:
                        game.competitorArray[i].team = Int16(TeamAssignment.teamB.rawValue)
                    case 3:
                        game.competitorArray[i].team = Int16(TeamAssignment.teamB.rawValue)
                    default:
                        game.competitorArray[i].team = Int16(TeamAssignment.indiv.rawValue)
                    }
                }
            case 2:
                //need to switch over singles matchplay and then all the 2P versions of 4P games, as for these both competitors will be in TeamA
                
                switch currentGF.assignShotsRecd{
                 //for singles matchplay
                case .Indiv:
                    for i in 0..<(game.competitorArray.count)    {
                        switch i {
                        case 0:
                            game.competitorArray[i].team = Int16(TeamAssignment.teamA.rawValue)
                        case 1:
                            game.competitorArray[i].team = Int16(TeamAssignment.teamB.rawValue)
                        default:
                            game.competitorArray[i].team = Int16(TeamAssignment.indiv.rawValue)
                        }
                    }
                    //for 2P versions of 4P game formats
                case.TeamsAB:
                    for i in 0..<(game.competitorArray.count)    {
                        game.competitorArray[i].team = Int16(TeamAssignment.teamA.rawValue)
                    }
                default:
                    break
                    
                    
                }
            default:
                game.competitorArray[0].team = Int16(TeamAssignment.indiv.rawValue)
            }
        case .TeamC:
            for i in 0..<(game.competitorArray.count) {
                game.competitorArray[i].team = Int16(TeamAssignment.teamC.rawValue)
            }
        }
    }
    
    func AssignPlayingHandicaps (game: Game, currentGF: CurrentGameFormat) {
        switch currentGF.competitorSort {
        case .TeamsAB:
            
            func TeamABLowHigh (competitors: [Competitor]) -> (teamALow:Competitor, teamAHigh: Competitor, teamBLow: Competitor, teamBHigh: Competitor){
                let teamA = competitors.filter({$0.team == TeamAssignment.teamA.rawValue})
                let teamB = competitors.filter({$0.team == TeamAssignment.teamB.rawValue})
                let teamAHigh = teamA.filter({$0.courseHandicap == teamA.map{$0.courseHandicap}.max()})
                let teamBHigh = teamB.filter({$0.courseHandicap == teamB.map{$0.courseHandicap}.max()})
                let teamALow = teamA.filter({$0.courseHandicap == teamA.map{$0.courseHandicap}.min()})
                let teamBLow = teamB.filter({$0.courseHandicap == teamB.map{$0.courseHandicap}.min()})
                
                return (teamALow[0], teamAHigh[0], teamBLow[0], teamBHigh[0])
            }
            
            func TeamABLowHigh2P (competitors: [Competitor]) -> (teamALow:Competitor, teamAHigh: Competitor){
                let teamA = competitors.filter({$0.team == TeamAssignment.teamA.rawValue})
                //let teamB = competitors.filter({$0.team == TeamAssignment.teamB.rawValue})
                let teamAHigh = teamA.filter({$0.courseHandicap == teamA.map{$0.courseHandicap}.max()})
               // let teamBHigh = teamB.filter({$0.courseHandicap == teamB.map{$0.courseHandicap}.max()})
                let teamALow = teamA.filter({$0.courseHandicap == teamA.map{$0.courseHandicap}.min()})
                //let teamBLow = teamB.filter({$0.courseHandicap == teamB.map{$0.courseHandicap}.min()})
                
                return (teamALow[0], teamAHigh[0])
            }
            
            
            switch currentGF.noOfPlayersNeeded{
            case 4:
                let teamALowIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamALow.id})
                let teamAHighIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamAHigh.id})
                let teamBLowIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamBLow.id})
                let teamBHighIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamBHigh.id})
                
                game.competitorArray[teamALowIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[0]
                game.competitorArray[teamAHighIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[1]
                game.competitorArray[teamBLowIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[2]
                game.competitorArray[teamBHighIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[3]
                
                
            case 2:
                // add code for 2 player versions of teamAB - this wont pick up singles matchplay
                
                let teamALowIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh2P(competitors: game.competitorArray).teamALow.id})
                let teamAHighIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh2P(competitors: game.competitorArray).teamAHigh.id})

                game.competitorArray[teamALowIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[0]
                game.competitorArray[teamAHighIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[1]
                
                
//                for i in 0..<game.competitorArray.count {
//                    game.competitorArray[i].handicapAllowance = currentGF.playerHandAllowances[i]
//                }
            default:
                for i in 0..<game.competitorArray.count {
                    game.competitorArray[i].handicapAllowance = currentGF.playerHandAllowances[i]
                }
            }
        case .Indiv:
            for i in 0..<game.competitorArray.count {
                game.competitorArray[i].handicapAllowance = currentGF.playerHandAllowances[i]
            }
            
        case .TeamC:
            let sortedCompetitors = game.competitorArray.sorted(by: {$0.handicapIndex < $1.handicapIndex})
            
            for i in 0..<sortedCompetitors.count {
                sortedCompetitors[i].handicapAllowance = currentGF.playerHandAllowances[i]
            }
        }
        // NOW ASSIGN THE PLAYING HANDICAP - need to round the course handicap as is an exact double. ALSO NEED A switch statement, based on game format to determine if playing handicap is exact or rounded.
        switch currentGF.assignShotsRecd {
        case .Indiv:
            for i in 0..<game.competitorArray.count {
                game.competitorArray[i].playingHandicap = round(game.competitorArray[i].courseHandicap) * game.competitorArray[i].handicapAllowance
            }
        case .TeamsAB:
            for i in 0..<game.competitorArray.count {
                game.competitorArray[i].playingHandicap = round(game.competitorArray[i].courseHandicap) * game.competitorArray[i].handicapAllowance
            }
        case .TeamC:
            for i in 0..<game.competitorArray.count {
                game.competitorArray[i].playingHandicap = round(game.competitorArray[i].courseHandicap) * game.competitorArray[i].handicapAllowance
            }
        }

    }
    

    
    func AssignTeamPlayingHandicap(game: Game, currentGF: CurrentGameFormat) {
        var totalPlayingHandicap: Double = 0
        switch currentGF.assignShotsRecd {
            
        case .Indiv:
            break

            
        case .TeamsAB:
            for PH in game.competitorArray.filter({$0.team == 1}) {
                totalPlayingHandicap += round(PH.playingHandicap*1000)/1000
            }
 
            if !game.teamShotsArray.isEmpty {
                game.teamShotsArray[0].playingHandicap = totalPlayingHandicap
                game.teamShotsArray[2].playingHandicap = 0
            }
            totalPlayingHandicap = 0
            
            for PH in game.competitorArray.filter({$0.team == 2}) {
                totalPlayingHandicap += round(PH.playingHandicap*1000)/1000
            }
            //game.teamBPlayingHandicap = totalPlayingHandicap
            if !game.teamShotsArray.isEmpty {
                game.teamShotsArray[1].playingHandicap = totalPlayingHandicap
                game.teamShotsArray[2].playingHandicap = 0
            }
            totalPlayingHandicap = 0
            
        case .TeamC:
            for PH in game.competitorArray.filter({$0.team == 3}) {
                totalPlayingHandicap += round(PH.playingHandicap*1000)/1000
            }
            if !game.teamShotsArray.isEmpty {
                game.teamShotsArray[2].playingHandicap = totalPlayingHandicap
                game.teamShotsArray[0].playingHandicap = 0
                game.teamShotsArray[1].playingHandicap = 0
            }
//            game.teamAPlayingHandicap = 0
//            game.teamBPlayingHandicap = 0
//            totalPlayingHandicap = 0
        }
    }
    
    
    
    func AssignShotsReceived (game: Game, currentGF: CurrentGameFormat) {
        // I THINK I NEED A SWITCH STATEMENT HERE ON WHETHER STROKEPLAY OR MATCHPLAY
        switch currentGF.playFormat {
        case .strokeplay:
            break
        case .matchplay:
            switch currentGF.assignShotsRecd {
            case .Indiv:
                var competitorsTotalPH: [Double] = Array(repeating: 0.0, count: game.competitorArray.count)
                for i in 0..<game.competitorArray.count {
                    competitorsTotalPH[i] = round(game.competitorArray[i].playingHandicap) + game.competitorArray[i].diffTeesXShots
                }
                let lowPH = competitorsTotalPH.min() ?? 0
                
                for i in 0..<game.competitorArray.count {
                    game.competitorArray[i].shotsRecdMatch = (round(game.competitorArray[i].playingHandicap) + game.competitorArray[i].diffTeesXShots) - lowPH
                }
                
//                game.teamAShotsReceived = 0
//                game.teamBShotsReceived = 0
                
                
            case .TeamsAB:
                switch currentGF.playFormat {
                case .matchplay:
                    //handicap totals for the teams must be rounded prior to working out difference in shots *** NOT ALWAYS
                    //in grrensomes fourssome chapman pinehurst, you add the EXACT handicaps together, then work out the difference and THEN ROUND
                    
                    
//                    let A = game.teamAPlayingHandicap + game.teamADiffTeesXShots
//                    let B = game.teamBPlayingHandicap + game.teamBDiffTeesXShots
                    if !game.teamShotsArray.isEmpty {
                        let A = game.teamShotsArray[0].playingHandicap + game.teamShotsArray[0].diffTeesXShots
                        let B = game.teamShotsArray[1].playingHandicap + game.teamShotsArray[1].diffTeesXShots
                        
                        
                        
                        
                        let lowTeamHandicap = min(A,B)
                        
                        let ASR = A - lowTeamHandicap
                        let BSR = B - lowTeamHandicap
                        
//                        game.teamAShotsReceived = round(ASR)
//                        game.teamBShotsReceived = round(BSR)
                        
                        game.teamShotsArray[0].shotsRecd = round(ASR)
                        game.teamShotsArray[1].shotsRecd = round(BSR)
                        
                        print("team a \(game.teamShotsArray[0].team)")
                        print("team a shots recd \(round(ASR))")
                        print("team a playing handicap \(game.teamShotsArray[0].playingHandicap)")
                        print("team a diff tees \(game.teamShotsArray[0].diffTeesXShots)")
                        print("team b \(game.teamShotsArray[1].team)")
                        print("team b shots recd\(round(BSR))")
                        print("team b playing handicap \(game.teamShotsArray[1].playingHandicap)")
                        print("team b diff tees \(game.teamShotsArray[1].diffTeesXShots)")
                    }
                case .strokeplay:
                    switch currentGF.noOfPlayersNeeded{
                    case 2:
                        //game.teamAShotsReceived = round(game.teamAPlayingHandicap+game.teamBPlayingHandicap)
                        if !game.teamShotsArray.isEmpty {
                            game.teamShotsArray[0].shotsRecd = round(game.teamShotsArray[0].playingHandicap + game.teamShotsArray[1].playingHandicap)
                            
                        }
                    default://not sure this is CORRECT. WHat about 4 player foursomes, greensomes etc
//                        game.teamAShotsReceived = 0
//                        game.teamBShotsReceived = 0
                        if !game.teamShotsArray.isEmpty {
                            game.teamShotsArray[0].shotsRecd = 0
                            game.teamShotsArray[1].shotsRecd = 0
                        }
                    }
                  
                }
                
            case .TeamC:
                break
//                game.teamAShotsReceived = 0
//                game.teamBShotsReceived = 0
            }
        }
    }
    
    func AssignExtraShots (game: Game, currentGF: CurrentGameFormat){
        switch game.TeeBoxesAllSame(){
        case true:
            for i in 0..<game.competitorArray.count {
                game.competitorArray[i].diffTeesXShots = 0.0
            }
        case false:
            switch game.scoreFormat {
            case 0: //medal - NOTE will need a special version for Texas Scramble where extra shots are divided by number of players
                
                var courseRatings: [Double] = []
                
                for i in 0..<game.competitorArray.count {
                    courseRatings.append(game.competitorArray[i].CourseRating())
                }
                let lowCR = round(courseRatings.min()!*1000)/1000
                var courseRatingsAdj: [Double] = []
                for i in 0..<game.competitorArray.count {
                    courseRatingsAdj.append(round(game.competitorArray[i].CourseRating() * 1000)/1000 - lowCR)
                    game.competitorArray[i].diffTeesXShots = courseRatingsAdj[i]
                }
                
                
            case 1: //stableford
//                The number of stableford points required to play to Handicap is calculated for each set of tees and rounded to the nearest whole number.
//
//                Points required to play to Handicap   =    36   -   [ Course Rating  -  Par ]
//
//                A player competing from a set of tees requiring a lower number of points to play to Handicap will receive additional strokes equal to the difference in the number of points required to play to Handicap.
//
//                Playing Handicap  =  [Course Handicap  X  Handicap Allowance]
//                                                               +  Difference in points required to play to handicap
                
//                print("Stableford")
                var SPR: [Double] = []
                for i in 0..<game.competitorArray.count {
                    SPR.append(36 - (game.competitorArray[i].CourseRating() - Double(game.competitorArray[i].teeBox?.TotalPar() ?? 0)))
//                    print("\(game.competitorArray[i].TeeBoxColour()) \(36 - (game.competitorArray[i].CourseRating() - Double(game.competitorArray[i].teeBox?.TotalPar() ?? 0)))")
//                    print(game.competitorArray[i].CourseRating())
//                    print(game.competitorArray[i].teeBox?.TotalPar() ?? 0)
                }
                let highSPR = SPR.max()!*1000/1000
                var SPRAdj: [Double] = []
                for i in 0..<game.competitorArray.count {
                    SPRAdj.append(highSPR - (36 - (game.competitorArray[i].CourseRating() - Double(game.competitorArray[i].teeBox?.TotalPar() ?? 0))))
                    game.competitorArray[i].diffTeesXShots = SPRAdj[i]
                }
                
               
            default: //bogey
                var SPR: [Double] = []
                for i in 0..<game.competitorArray.count {
                    SPR.append(36 - (game.competitorArray[i].CourseRating() - Double(game.competitorArray[i].teeBox?.TotalPar() ?? 0)))
//                    print("\(game.competitorArray[i].TeeBoxColour()) \(36 - (game.competitorArray[i].CourseRating() - Double(game.competitorArray[i].teeBox?.TotalPar() ?? 0)))")
//                    print(game.competitorArray[i].CourseRating())
//                    print(game.competitorArray[i].teeBox?.TotalPar() ?? 0)
                }
                let highSPR = SPR.max()!*1000/1000
                var SPRAdj: [Double] = []
                for i in 0..<game.competitorArray.count {
                    SPRAdj.append(highSPR - (36 - (game.competitorArray[i].CourseRating() - Double(game.competitorArray[i].teeBox?.TotalPar() ?? 0))))
                    game.competitorArray[i].diffTeesXShots = SPRAdj[i]
                }
            }
        }
    }
    
    
    func AssignTeamExtraShots(game: Game, currentGF: CurrentGameFormat) { //dont think i need a switch statement on teeboxesallsame as only addes up indivuals extra shots calculated in func before
        var totalExtraShots: Double = 0
        switch currentGF.assignShotsRecd {
            
            
        case .Indiv:
            //        No change. Each individual gets their playing handincap
        break
            
        case .TeamsAB:
            //        Add team A extra shots and assign to Game.Team
            for competitor in game.competitorArray.filter({$0.team == 1}) {
                totalExtraShots += round(competitor.diffTeesXShots*1000)/1000
            }
            //game.teamADiffTeesXShots = (totalExtraShots*currentGF.extraShotsTeamAdj)
            if !game.teamShotsArray.isEmpty {
                game.teamShotsArray[0].diffTeesXShots = (totalExtraShots*currentGF.extraShotsTeamAdj)
                game.teamShotsArray[2].diffTeesXShots = 0
            }
            
            
            totalExtraShots = 0
            
            
            
            for competitor in game.competitorArray.filter({$0.team == 2}) {
                totalExtraShots += round(competitor.diffTeesXShots*1000)/1000
            }
            //game.teamBDiffTeesXShots = (totalExtraShots*currentGF.extraShotsTeamAdj)
            if !game.teamShotsArray.isEmpty {
                game.teamShotsArray[1].diffTeesXShots = (totalExtraShots*currentGF.extraShotsTeamAdj)
                game.teamShotsArray[2].diffTeesXShots = 0
            }
            totalExtraShots = 0
            
            
            
        case .TeamC:
            for competitor in game.competitorArray.filter({$0.team == 3}) {
                totalExtraShots += round(competitor.diffTeesXShots*1000)/1000
            }
            if !game.teamShotsArray.isEmpty {
                game.teamShotsArray[2].diffTeesXShots = (totalExtraShots*currentGF.extraShotsTeamAdj)
                game.teamShotsArray[0].diffTeesXShots = 0
                game.teamShotsArray[1].diffTeesXShots = 0
            }
            totalExtraShots = 0
        }
        
    }
  
    
    func AssignTeamTeeBox(game: Game, currentGF: CurrentGameFormat) {
        switch currentGF.assignShotsRecd {
        case .Indiv:
            break
        case .TeamsAB:
            let manager = CoreDataManager.shared
            let teamTeeBox_A = TeamTeeBox(context: manager.persistentContainer.viewContext)
            let teamTeeBox_B = TeamTeeBox(context: manager.persistentContainer.viewContext)
            teamTeeBox_A.game = game
            teamTeeBox_B.game = game
            teamTeeBox_A.courseRating = game.defaultTeeBox?.courseRating ?? 0.0
            teamTeeBox_A.slopeRating = game.defaultTeeBox?.slopeRating ?? 0
            teamTeeBox_A.teeBoxColour = game.defaultTeeBox?.wrappedColour
            teamTeeBox_A.color = game.defaultTeeBox?.teeBoxColor
            teamTeeBox_B.courseRating = game.defaultTeeBox?.courseRating ?? 0.0
            teamTeeBox_B.slopeRating = game.defaultTeeBox?.slopeRating ?? 0
            teamTeeBox_B.teeBoxColour = game.defaultTeeBox?.wrappedColour
            teamTeeBox_B.color = game.defaultTeeBox?.teeBoxColor
            
            manager.save()
            
        case .TeamC:
            let manager = CoreDataManager.shared
            let teamTeeBox_C = TeamTeeBox(context: manager.persistentContainer.viewContext)
            
            teamTeeBox_C.game = game
            
            teamTeeBox_C.courseRating = game.defaultTeeBox?.courseRating ?? 0.0
            teamTeeBox_C.slopeRating = game.defaultTeeBox?.slopeRating ?? 0
            teamTeeBox_C.teeBoxColour = game.defaultTeeBox?.wrappedColour
            teamTeeBox_C.color = game.defaultTeeBox?.teeBoxColor
            
            
            manager.save()
        }
    }
    
    
}


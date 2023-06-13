//
//  StartGameViewModel.swift
//  GolfProto04
//
//  Created by Philip Nye on 24/04/2023.
//

import Foundation
import SwiftUI


class StartGameViewModel: ObservableObject {
    @StateObject private var playerListVM = PlayerListViewModel()
    @StateObject private var clubListVM = ClubListViewModel()
    @EnvironmentObject var currentGF: CurrentGameFormat
    @StateObject private var gameListVM = GameListViewModel()
    //game
    var clubName: String = ""
    var courseName: String = ""
    var distMetric: Int = 0
    //competitor
    var color: UIColor = UIColor(.clear)
    var teeBoxColour: String = ""
    var courseRating: Double = 0.0
    var slopeRating: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var gender: Int = 0
    
    func ResumeGame() {
        
    }
    
    
    
    func StartGame(game: Game, currentGF: CurrentGameFormat) {
        let manager = CoreDataManager.shared

//        let currentGame = manager.getGameById(id: game.objectID)
        game.clubName = game.defaultTeeBox?.course?.club?.name
        game.courseName = game.defaultTeeBox?.course?.name
        game.distMetric = game.defaultTeeBox?.course?.club?.distMetric ?? 0
        game.dTB_slopeRating = Int16(game.defaultTeeBox?.slopeRating ?? 0)
        game.dTB_courseRating = game.defaultTeeBox?.courseRating ?? 0.0
        game.dTB_Color = game.defaultTeeBox?.wrappedColour
        game.dTB_teeBoxColour = game.defaultTeeBox?.teeBoxColor
        
        
        for i in 0..<game.competitorArray.count {
            game.competitorArray[i].courseRating = game.competitorArray[i].CourseRating()
            game.competitorArray[i].color = game.competitorArray[i].color ?? UIColor(.clear)
            game.competitorArray[i].slopeRating = Int16(game.competitorArray[i].SlopeRating())
            game.competitorArray[i].teeBoxColour = game.competitorArray[i].TeeBoxColour()
            game.competitorArray[i].firstName = game.competitorArray[i].FirstName()
            game.competitorArray[i].lastName = game.competitorArray[i].LastName()
            game.competitorArray[i].gender = Int16(game.competitorArray[i].player?.pl_gender.rawValue ?? 0)
         
            // player photo ??
        }
        
        // if handicap allocated by indiv then COmpetitor Scorecard gets created else team scorecard and team teeBox
        
        
        switch currentGF.assignShotsRecd {
        case .Indiv:
            //create a scorecard for each competitor
            
            for i in 0..<game.competitorArray.count {
               // let cs = CompetitorScore(context: manager.persistentContainer.viewContext)
                
                var holes = game.competitorArray[i].teeBox?.holesArray.sorted(by: {$0.number < $1.number})
                
                for j in 0..<(holes?.count ?? 0) {
                    let cs = CompetitorScore(context: manager.persistentContainer.viewContext)
                    
                    cs.competitor = game.competitorArray[i]
                    cs.hole = Int16(j + 1)
                    cs.distance = Int16(holes?[j].distance ?? 0)
                    cs.par = Int16(holes?[j].par ?? 0)
                    cs.strokeIndex = Int16(holes?[j].strokeIndex ?? 0)
                    
                    cs.shotsRecdHoleMatch = Int16(game.competitorArray[i].ShotsReceived(holeIndex: j, shots: game.competitorArray[i].shotsRecdMatch))
                    cs.shotsRecdHoleStroke = Int16(game.competitorArray[i].ShotsReceived(holeIndex: j, shots: game.competitorArray[i].TotalPlayingHandicap(currentGF: currentGF)))
                    manager.save()
                }
                holes = []
                
               // game.competitorArray[i]
                manager.save()
            }
        case .TeamsAB:
            //***WHEN CREATING TEAM SCORECARDS, IF TEAMS AB THEN 2 TEAM SCORECARDS AND IF TEAM C JUST 1 TEAM SCORECARD*****
            //IF THE TEEBOXES ARE THE SAME, THEN USE THE FIRST COMPETITORS.
            
            //IF THE TEEBOXES ARE NOT THE SAME, THEN USE THE GAME.DIFFTEES TEEBOX
              // CREATE THREE SCORECARDS FOR TEAMS A B & C
                
//            }
            switch game.TeeBoxesAllSame(){
            case true:
                if !game.competitorArray.isEmpty{
                    let holes = game.competitorArray[0].teeBox?.holesArray.sorted(by: {$0.number < $1.number})
                   
                    for i in 0..<2 {
                        
                        for j in 0..<(holes?.count ?? 0){
                            let ts = TeamScore(context: manager.persistentContainer.viewContext)
                            ts.game = game
                            ts.team = Int16(i)
                            ts.hole = Int16(j + 1)
                            ts.distance = Int16(holes?[j].distance ?? 0)
                            ts.par = Int16(holes?[j].par ?? 0)
                            ts.strokeIndex = Int16(holes?[j].strokeIndex ?? 0)
                           

                            
                            manager.save()
                            
                        }
                    }
                    for i in 0..<2 {
                        let shotsStroke = Double(game.teamShotsArray[i].playingHandicap + game.teamShotsArray[i].diffTeesXShots)
                        let shotsMatch = Double(game.teamShotsArray[i].shotsRecd)
                       
                        let teamScores = Array(game.teamScoresArray.filter({$0.team == i}))
                        
                        for ts in teamScores {
                            ts.shotsRecdHoleStroke = Int16(game.ShotsReceivedByTeamPerHole(strokeIndex: Int(ts.strokeIndex), shots: shotsStroke))
                            ts.shotsRecdHoleMatch = Int16(game.ShotsReceivedByTeamPerHole(strokeIndex: Int(ts.strokeIndex), shots: shotsMatch))
                        }
                    }
                    manager.save()
                }
            case false:
                
               
                let holes = game.diffTeesTeeBox?.holesArray.sorted(by: {$0.number < $1.number})
                
                for i in 0..<2 {
                    
                    for j in 0..<(holes?.count ?? 0){
                        let ts = TeamScore(context: manager.persistentContainer.viewContext)
                        ts.game = game
                        ts.team = Int16(i)
                        ts.hole = Int16(j + 1)
                        ts.distance = Int16(holes?[j].distance ?? 0)
                        ts.par = Int16(holes?[j].par ?? 0)
                        ts.strokeIndex = Int16(holes?[j].strokeIndex ?? 0)
                        
                        
//                        let shotsStroke = Double(game.teamShotsArray[i].playingHandicap + game.teamShotsArray[i].diffTeesXShots)
//                        let shotsMatch = Double(game.teamShotsArray[i].shotsRecd)
//                        ts.shotsRecdHoleStroke = Int16(game.ShotsReceivedByTeam(holeIndex: j, shots: shotsStroke, team: Int16(i)))
//                        ts.shotsRecdHoleMatch = Int16(game.ShotsReceivedByTeam(holeIndex: j, shots: shotsMatch, team: Int16(i)))
                        //CODE HERE FOR ADDING IN SHOTS RECEIVED MATCH AND STROKEPLAY
                        
                        //ts.shotsRecdMatch = Int16(game)
                        
                        manager.save()
                       
                    }
                }
                
                for i in 0..<2 {
                    let shotsStroke = Double(game.teamShotsArray[i].playingHandicap + game.teamShotsArray[i].diffTeesXShots)
                    let shotsMatch = Double(game.teamShotsArray[i].shotsRecd)
                   
                    let teamScores = Array(game.teamScoresArray.filter({$0.team == i}))
                    
                    for ts in teamScores {
                        ts.shotsRecdHoleStroke = Int16(game.ShotsReceivedByTeamPerHole(strokeIndex: Int(ts.strokeIndex), shots: shotsStroke))
                        ts.shotsRecdHoleMatch = Int16(game.ShotsReceivedByTeamPerHole(strokeIndex: Int(ts.strokeIndex), shots: shotsMatch))
                    }
                }
                
                manager.save()
                
                
            }
            
        case .TeamC:
            switch game.TeeBoxesAllSame(){
            case true:
                if !game.competitorArray.isEmpty{
                    let holes = game.competitorArray[0].teeBox?.holesArray.sorted(by: {$0.number < $1.number})
                    //print(holes?.count.formatted() ?? 99)
                   
                    
                    if !(holes?.isEmpty ?? false){
                        for j in 0..<(holes?.count ?? 0){
                            let ts = TeamScore(context: manager.persistentContainer.viewContext)
                            ts.game = game
                            ts.team = Int16(2)
                            ts.hole = Int16(j + 1)
                            ts.distance = Int16(holes?[j].distance ?? 0)
                            ts.par = Int16(holes?[j].par ?? 0)
                            ts.strokeIndex = Int16(holes?[j].strokeIndex ?? 0)
                            
                            //CODE HERE FOR ADDING IN SHOTS RECEIVED MATCH AND STROKEPLAY
                            
                            //ts.shotsRecdMatch = Int16(game)
                            
//                            let shotsStroke = Double(game.teamShotsArray[2].playingHandicap + game.teamShotsArray[2].diffTeesXShots)
//                            let shotsMatch = Double(game.teamShotsArray[2].shotsRecd)
//                            ts.shotsRecdHoleStroke = Int16(game.ShotsReceivedByTeam(holeIndex: j, shots: shotsStroke, team: Int16(2)))
//                            ts.shotsRecdHoleMatch = Int16(game.ShotsReceivedByTeam(holeIndex: j, shots: shotsMatch, team: Int16(2)))
                            
                            manager.save()
                           
                        }
                    }
                    
                    
                        let shotsStroke = Double(game.teamShotsArray[2].playingHandicap + game.teamShotsArray[2].diffTeesXShots)
                        let shotsMatch = Double(game.teamShotsArray[2].shotsRecd)
                       
                        let teamScores = game.teamScoresArray
                        
                        for ts in teamScores {
                            ts.shotsRecdHoleStroke = Int16(game.ShotsReceivedByTeamPerHole(strokeIndex: Int(ts.strokeIndex), shots: shotsStroke))
                            ts.shotsRecdHoleMatch = Int16(game.ShotsReceivedByTeamPerHole(strokeIndex: Int(ts.strokeIndex), shots: shotsMatch))
                        }
                    
                    
                    manager.save()
                    
                    
                }
            case false:
                let holes = game.diffTeesTeeBox?.holesArray.sorted(by: {$0.number < $1.number})
                
                for j in 0..<(holes?.count ?? 0){
                    let ts = TeamScore(context: manager.persistentContainer.viewContext)
                    ts.game = game
                    ts.team = Int16(2)
                    ts.hole = Int16(j + 1)
                    ts.distance = Int16(holes?[j].distance ?? 0)
                    ts.par = Int16(holes?[j].par ?? 0)
                    ts.strokeIndex = Int16(holes?[j].strokeIndex ?? 0)
                    
                    //CODE HERE FOR ADDING IN SHOTS RECEIVED MATCH AND STROKEPLAY
                    
                    //ts.shotsRecdMatch = Int16(game)
                    
                    manager.save()
                   
                }
            }
            
            let shotsStroke = Double(game.teamShotsArray[2].playingHandicap + game.teamShotsArray[2].diffTeesXShots)
            let shotsMatch = Double(game.teamShotsArray[2].shotsRecd)
           
            let teamScores = game.teamScoresArray
            
            for ts in teamScores {
                ts.shotsRecdHoleStroke = Int16(game.ShotsReceivedByTeamPerHole(strokeIndex: Int(ts.strokeIndex), shots: shotsStroke))
                ts.shotsRecdHoleMatch = Int16(game.ShotsReceivedByTeamPerHole(strokeIndex: Int(ts.strokeIndex), shots: shotsMatch))
            }
        
        
        manager.save()
       
        }
        
        switch currentGF.assignShotsRecd {
            
            // need to assign a value to the for the teebox that will be used on the score entry screen
        case .Indiv:
            game.scoreEntryTeeBox = game.defaultTeeBox
        default:
            switch game.TeeBoxesAllSame(){
            case true:
                game.scoreEntryTeeBox = game.defaultTeeBox
                
            case false:
                game.scoreEntryTeeBox = game.diffTeesTeeBox
            }
        }
        
        
        // competitor shots received by hole - this is added into the CompetitorScore instances
        
        
        // team score
        
        
        //team teebox
       
    
        
        game.started = true
        manager.save()
        
        
        
    }
    
   
    
}

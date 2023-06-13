//
//  ScoreEntryViewModel.swift
//  GolfProto04
//
//  Created by Philip Nye on 25/04/2023.
//

import Foundation
import SwiftUI


class ScoreEntryViewModel: ObservableObject {
    @StateObject private var gameListVM = GameListViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @Published var holeIndex: Int = 0
    
    @Published var grossScore: Int = 0
    @Published var competitorsScores: [[Int]] = Array(repeating: [0,0,0,0], count: 18)
    @Published var teamsScores: [[Int]] = Array(repeating: [0,0], count: 18) //WHEN TEAMS A&B USE 0,1 AND WHEN TEAM C USE 0
    @Published var scoresCommitted: [[Bool]] = Array(repeating: [false,false,false,false], count: 18)
    @Published var currentGame: GameViewModel = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
   
    
    @Published var currentMatchScore: Int = 0
    @Published var holesCommitted: Int = 0
    
    
    func assignDefaultValues(currentGF: CurrentGameFormat){
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        for i in 0..<(game?.competitorArray.count ?? 0) {
            for j in 0..<18 {
                let par = Int(game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].par ?? 0)
                let stroke = Int(game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].shotsRecdHoleStroke ?? 0)
                let score = par + stroke
                
                self.competitorsScores[j][i] = score
                self.scoresCommitted[j][i] = false
            }
        }
    
    }
    
    func assignDefaultValuesTeams(){//doesnt work for team c
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        for i in 0..<2 {
            for j in 0..<18 {
                let par = game?.teamScoresArray.filter({$0.team == i}).sorted(by: {$0.hole < $1.hole})[j].par
                let stroke = game?.teamScoresArray.filter({$0.team == i}).sorted(by: {$0.hole < $1.hole})[j].shotsRecdHoleStroke
                let score = Int(par ?? 0) + Int(stroke ?? 0)
                self.teamsScores[j][i] = score
                self.scoresCommitted[j][i] = false
               
                print("\(i) \(j)")
                print("par \(par as Any)")
                print(game?.teamScoresArray.filter({$0.team == i}).sorted(by: {$0.hole < $1.hole})[j].distance as Any)
                print("stroke \(stroke as Any)")
                print("score \(score as Any)")
                print("match shots recd\(game?.teamScoresArray.filter({$0.team == i}).sorted(by: {$0.hole < $1.hole})[j].shotsRecdHoleMatch as Any)")
            }
        }
    }
    
    func assignDefaultValuesTeamC () {
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        for j in 0..<18 {
//            let par = game?.teamScoresArray.sorted(by: {$0.hole < $1.hole})[j].par
//            //let stroke = game?.teamScoresArray.sorted(by: {$0.hole < $1.hole})[j].shotsRecdHoleStroke
            self.teamsScores[j][0] = Int(game?.teamScoresArray.sorted(by: {$0.hole < $1.hole})[j].par ?? 0)
            self.scoresCommitted[j][0] = false
        }
    }
    
    
    
    
    
    
    func loadCompetitorsScore(currentGF: CurrentGameFormat) {
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        for i in 0..<(game?.competitorArray.count ?? 0) {
            for j in 0..<18 {
                self.competitorsScores[j][i] = Int(game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].grossScore ?? 0)
                self.scoresCommitted[j][i] = Bool(game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].scoreCommitted ?? false)
            }
        }
        
        
    }
    
    func loadTeamScore(){
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        for i in 0..<2 {
            for j in 0..<18 {
                
                self.teamsScores[j][i] = Int(game?.teamScoresArray.filter({$0.team == i}).sorted(by: {$0.hole < $1.hole})[j].grossScore ?? 0)
                self.scoresCommitted[j][i] = Bool(game?.teamScoresArray.filter({$0.team == i}).sorted(by: {$0.hole < $1.hole})[j].scoreCommitted ?? false)
                
                
                
                
            }
        }
    }
    
    func loadTeamCScore(){
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        for j in 0..<18 {
            self.teamsScores[j][0] = Int(game?.teamScoresArray.sorted(by: {$0.hole < $1.hole})[j].grossScore ?? 0)
            self.scoresCommitted[j][0] = Bool(game?.teamScoresArray.sorted(by: {$0.hole < $1.hole})[j].scoreCommitted ?? false)
        }
    }
    
    
    
    
    
    
    
    
    func saveCompetitorsScore(currentGF: CurrentGameFormat) {
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        
        for i in 0..<(game?.competitorArray.count ?? 0) {
            for j in 0..<18 {
                game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].grossScore = Int16(self.competitorsScores[j][i])
                game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].scoreCommitted = self.scoresCommitted[j][i]
            }
        }
        
        manager.save()
    }
    
    // similar func for TEAM
    func saveCompetitorsScoreTeam() {
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        for i in 0..<2 {
            for j in 0..<18 {
                game?.teamScoresArray.filter({$0.team == i}).sorted(by: {$0.hole < $1.hole})[j].grossScore = Int16(self.teamsScores[j][i])
                game?.teamScoresArray.filter({$0.team == i}).sorted(by: {$0.hole < $1.hole})[j].scoreCommitted = self.scoresCommitted[j][i]
            }
        }
        manager.save()
    }

    func saveCompetitorsScoreTeam2P() {
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        
            for j in 0..<18 {
                game?.teamScoresArray.filter({$0.team == 0}).sorted(by: {$0.hole < $1.hole})[j].grossScore = Int16(self.teamsScores[j][0])
                game?.teamScoresArray.filter({$0.team == 0}).sorted(by: {$0.hole < $1.hole})[j].scoreCommitted = self.scoresCommitted[j][0]
            }
        
        manager.save()
    }
    
    
    
    func saveCompetitorScoreTeamC() {
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        for j in 0..<18 {
            game?.teamScoresArray.sorted(by: {$0.hole < $1.hole})[j].grossScore = Int16(self.teamsScores[j][0])
            game?.teamScoresArray.sorted(by: {$0.hole < $1.hole})[j].scoreCommitted = self.scoresCommitted[j][0]
        }
    }
    
    
    
    
    
} //class


struct HoleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .padding(6)
            .background(burntOrange)
            .foregroundColor(.white)
          
            
    }
}

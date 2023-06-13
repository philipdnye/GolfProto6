//
//  TeamScoreViewModel.swift
//  GolfProto04
//
//  Created by Philip Nye on 23/04/2023.
//

import Foundation
import CoreData

class TeamScoreListViewModel: ObservableObject {
    
    @Published var teamScores = [TeamScoreViewModel]()
    
    func deleteTeamScore(teamScore: TeamScoreViewModel) {
        let teamScore = CoreDataManager.shared.getTeamScoreById(id: teamScore.teamScoreId)
        if let teamScore = teamScore {
            CoreDataManager.shared.deleteTeamScore(teamScore)
        }
    }
    
    func getTeamScoresByGame(vm: GameViewModel) {
        
        let game = CoreDataManager.shared.getGameById(id: vm.id)
        if let game = game {
            DispatchQueue.main.async {
                self.teamScores = (game.teamScores?.allObjects as! [TeamScore]).map(TeamScoreViewModel.init)
            }
        }
        
    }
    
}


struct TeamScoreViewModel: Hashable {
    let teamScore: TeamScore
    
    var teamScoreId: NSManagedObjectID {
        return teamScore.objectID
    }
    var distance: Int16 {
        return teamScore.distance
    }
    
    var grossScore: Int16 {
        return teamScore.grossScore
    }
    
    var hole: Int16 {
        return teamScore.hole
    }
    var par: Int16 {
        return teamScore.par
    }
    
    var shotsRecdMatch: Int16 {
        return teamScore.shotsRecdHoleMatch
    }
    var shotsRecdStroke: Int16 {
        return teamScore.shotsRecdHoleStroke
    }
    var strokeIndex: Int16 {
        return teamScore.strokeIndex
    }
    
}

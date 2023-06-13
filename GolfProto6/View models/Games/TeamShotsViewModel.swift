//
//  TeamShotsViewModel.swift
//  GolfProto04
//
//  Created by Philip Nye on 23/04/2023.
//

import Foundation
import CoreData

class TeamShotsListViewModel: ObservableObject {
    @Published var teamShots = [TeamShotsViewModel]()
    
    func deleteTeamShots(teamShots: TeamShotsViewModel) {
        let teamShots = CoreDataManager.shared.getTeamShotsById(id: teamShots.teamShotsId)
        if let teamShots = teamShots {
            CoreDataManager.shared.deleteTeamShots(teamShots)
        }
    }
    
    func getTeamShotsByGame(vm: GameViewModel) {
        
        let game = CoreDataManager.shared.getGameById(id: vm.id)
        if let game = game {
            DispatchQueue.main.async {
                self.teamShots = (game.teamShots?.allObjects as! [TeamShots]).map(TeamShotsViewModel.init)
            }
        }
        
    }
    
    
}

struct TeamShotsViewModel: Hashable {
    let teamShots: TeamShots
    
    var teamShotsId: NSManagedObjectID {
        return teamShots.objectID
    }
    
    var diffTeesXShots: Double {
        return teamShots.diffTeesXShots
    }
    var playingHandicap: Double {
        return teamShots.playingHandicap
    }
    var shotsRecd: Double {
        return teamShots.shotsRecd
    }
    var team: Int16 {
        return teamShots.team
    }
}

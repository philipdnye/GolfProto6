//
//  TeamTeeBoxViewModel.swift
//  GolfProto04
//
//  Created by Philip Nye on 23/04/2023.
//

import Foundation
import CoreData
import UIKit


class TeamTeeBoxListViewModel: ObservableObject {
    @Published var teamTeeBox = [TeamTeeBoxViewModel]()
    
    func deleteTeamTeeBox(teamTeeBox: TeamTeeBoxViewModel) {
        let teamTeeBox = CoreDataManager.shared.getTeamTeeBoxById(id: teamTeeBox.teamTeeBoxId)
        if let teamTeeBox = teamTeeBox {
            CoreDataManager.shared.deleteTeamTeeBox(teamTeeBox)
        }
    }
    
    func getTeamTeeBoxByGame(vm: GameViewModel) {
        
        let game = CoreDataManager.shared.getGameById(id: vm.id)
        if let game = game {
            DispatchQueue.main.async {
                self.teamTeeBox = (game.teamTeeBoxes?.allObjects as! [TeamTeeBox]).map(TeamTeeBoxViewModel.init)
            }
        }
        
    }
}

struct TeamTeeBoxViewModel: Hashable {
   
    let teamTeeBox: TeamTeeBox
    
    var teamTeeBoxId: NSManagedObjectID {
        return teamTeeBox.objectID
    }
    var courseRating: Double {
        return teamTeeBox.courseRating
    }
    
    var slopeRating: Int16 {
        return teamTeeBox.slopeRating
    }
    
    var team: Int16 {
        return teamTeeBox.team
    }
    var teeBoxColour: String {
        return teamTeeBox.teeBoxColour ?? ""
    }
    var color: UIColor {
   
        return teamTeeBox.color ?? UIColor.clear
    }
}

//
//  PlayerListViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 23/03/2023.
//

import Foundation
import CoreData
import SwiftUI

enum PlayerGender: Int, CaseIterable {
    case male = 0
    case female = 1
    
    func stringValue() -> String {
        switch(self){
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}


class PlayerListViewModel: NSObject, ObservableObject {
  
    @Published var players = [PlayerViewModel]()
    
    private var fetchedResultsController: NSFetchedResultsController<Player>!
    
    func deletePlayer(player: PlayerViewModel) {
        let player = CoreDataManager.shared.getPlayerById(id: player.id)
        if let player = player {
            CoreDataManager.shared.deletePlayer(player)
        }
    }
    
    
    
    func getAllPlayers () {
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        DispatchQueue.main.async {
            self.players = (self.fetchedResultsController.fetchedObjects ?? []).map(PlayerViewModel.init)
        }

    }
    
}
extension PlayerListViewModel: NSFetchedResultsControllerDelegate {
    
}

struct PlayerViewModel: Hashable {
    let player: Player
    
    var id: NSManagedObjectID {
        return player.objectID
    }
    
    var firstName: String {
        return player.firstName ?? ""
    }
    var lastName: String {
        return player.lastName ?? ""
    }
    var dateOfBirth: Date {
        return player.dateOfBirth ?? Date()
    }
    var gender: String{
        return player.pl_gender.stringValue()
    }
    var email: String {
        return player.email ?? ""
    }
    var mobile: String {
        return player.mobile ?? ""
    }
    var photo: UIImage {
      
        return player.photo ?? UIImage()
        

    }
    var selectedForGame: Bool {
        return player.selectedForGame
    }
    
//    var competitors: [CompetitorViewModel]{
//        return player.competitors
//    }
//    
//    var games: [Game]{
//        return player
//    }
//
//    var competitors: [Competitor] {
//        return player.competitors
//    }
}

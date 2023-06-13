//
//  HandicapListViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 23/03/2023.
//

import Foundation
import CoreData

class HandicapListViewModel: ObservableObject {
    
    @Published var handicapHistory = [Handicap]()
    
    func deleteHandicap(handicap: HandicapViewModel) {
        let handicap = CoreDataManager.shared.getHandicapById(id: handicap.handicapId)
        if let handicap = handicap {
            CoreDataManager.shared.deleteHandicap(handicap)
        }
    }
    
    
//    func getHandicapsByPlayer(vm: PlayerViewModel) {
//        let player = CoreDataManager.shared.getPlayerById(id: vm.id)
//        if let player = player {
////            DispatchQueue.main.async {
//                self.handicapHistory = (player.handicap?.allObjects as! [Handicap]).map(HandicapViewModel.init)
////            }
//        }
//    }
    func getHandicapsByPlayer(vm: PlayerViewModel) {

        let player = CoreDataManager.shared.getPlayerById(id: vm.id)
        if let player = player {
            DispatchQueue.main.async {
                self.handicapHistory = (player.handicapArray)
            }
        }
    }
    
}



struct HandicapViewModel {
    let handicap: Handicap
    var handicapId: NSManagedObjectID {
        return handicap.objectID
    }
    var startDate: Date {
        return handicap.startDate ?? Date()
    }
    
    var handicapIndex: Double {
        return handicap.handicapIndex
    }
}

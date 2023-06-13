//
//  AddHandicapViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 23/03/2023.
//

import Foundation

class AddHandicapViewModel: ObservableObject {
    
    
    
    var startDate: Date = Date()
   
    
    
    @Published var handicapIndex: Double = 20.0
    
    func addHandicapToPlayer(vm: PlayerViewModel) {
        let player = CoreDataManager.shared.getPlayerById(id: vm.id)
        let handicap = Handicap(context: CoreDataManager.shared.viewContext)
        
        handicap.startDate = startDate
        handicap.handicapIndex = handicapIndex
        handicap.player = player
       
        CoreDataManager.shared.save()
    }
    
    
    
}

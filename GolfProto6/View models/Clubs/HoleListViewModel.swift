//
//  HoleListViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//




import Foundation
import CoreData

class HoleListViewModel: ObservableObject {

    @Published var holes = [HoleViewModel]()
    @Published var holes2 = [Hole]()
    
    func getHolesByTeeBox(vm: TeeBoxViewModel) {

        let teeBox = CoreDataManager.shared.getTeeBoxById(id: vm.teeBoxId)
        if let teeBox = teeBox {
            DispatchQueue.main.async {
                self.holes = (teeBox.holes?.allObjects as! [Hole]).map(HoleViewModel.init)
            }
        }
    }
    
    func getHolesByTeeBox2(vm: TeeBoxViewModel) {

        let teeBox = CoreDataManager.shared.getTeeBoxById(id: vm.teeBoxId)
        if let teeBox = teeBox {
            DispatchQueue.main.async {
                self.holes2 = (teeBox.holesArray)
            }
        }
    }
  
}

struct HoleViewModel: Hashable {
   
    

    let hole: Hole

    var holeId: NSManagedObjectID {
        return hole.objectID
    }


    var number: Int16 {
        return hole.number
    }
    
    var distance: Int16 {
        return hole.distance
    }
    
    var par: Int16 {
        return hole.par
    }
    
    var strokeIndex: Int16 {
        return hole.strokeIndex
    }
    
    var name: String {
        return hole.name ?? ""
    }
    




}

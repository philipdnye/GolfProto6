//
//  AddHoleViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import Foundation

class AddHoleViewModel: ObservableObject {
    
    var name: String = ""
    
    var number: String = ""
    var distance: String = ""
    var par: String = ""
    var strokeIndex: String = ""
    
    
    func addRandomHolesToTeeBox(vm: TeeBoxViewModel){
        let teeBox = CoreDataManager.shared.getTeeBoxById(id: vm.teeBoxId)
        
        func calcPar(distance: Int) -> Int {
            if distance <= 245 {return 3}
            if distance >= 465 {return 5}
            return 4
        }
        var strokeIndexes = Array(1...18)
        
        for i in 0...17 {
            let hole = Hole(context: CoreDataManager.shared.viewContext)
          
            hole.teeBox = teeBox
            hole.name = name
            hole.number = Int16(i+1)
            hole.distance = Int16.random(in: 110..<550)
            hole.par = Int16(calcPar(distance: Int(exactly: hole.distance)!))
            hole.strokeIndex = Int16(strokeIndexes.randomElement()!)
            
            let position = strokeIndexes.firstIndex(of: Int(exactly: hole.strokeIndex)!)
            strokeIndexes.remove(at: position!)
           
            CoreDataManager.shared.save()
        }
    }
    
}

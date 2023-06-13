//
//  AddTeeBoxViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import Foundation
import SwiftUI

class AddTeeBoxViewModel: ObservableObject {
    var colour: String = ""
    var teeBoxColour: Color = Color.clear
    var courseRating: String = ""
    var slopeRating: String = ""
    
    func addTeeBoxToCourse(vm: CourseViewModel){
        let course = CoreDataManager.shared.getCourseById(id: vm.courseId)
        let teeBox = TeeBox(context: CoreDataManager.shared.viewContext)
        teeBox.colour = colour
        teeBox.course = course
        teeBox.teeBoxColor = UIColor(teeBoxColour)
        teeBox.slopeRating = Int16(slopeRating) ?? 0
        teeBox.courseRating = Double(courseRating) ?? 0.0
        
    
       
        
        
        CoreDataManager.shared.save()
        
        
    }
    func addTeeBoxToCourse2(vm: CourseViewModel) {
        let course = CoreDataManager.shared.getCourseById(id: vm.courseId)
        let teeBox = TeeBox(context: CoreDataManager.shared.viewContext)
        teeBox.colour = colour
        teeBox.course = course
        teeBox.teeBoxColor = UIColor(teeBoxColour)
        teeBox.slopeRating = Int16(slopeRating) ?? 0
        teeBox.courseRating = Double(courseRating) ?? 0.0
        CoreDataManager.shared.save()
        //save the teebox, get its ID
        let teeBoxForHoles = CoreDataManager.shared.getTeeBoxById(id: teeBox.objectID) ?? TeeBox()
        addRandomHolesToTeeBox2(teeBox: teeBoxForHoles)
    }
    
    func addRandomHolesToTeeBox2(teeBox: TeeBox){
        
        
        func calcPar(distance: Int) -> Int {
            if distance <= 245 {return 3}
            if distance >= 465 {return 5}
            return 4
        }
        var strokeIndexes = Array(1...18)
        
        for i in 0...17 {
            let hole = Hole(context: CoreDataManager.shared.viewContext)
          
            hole.teeBox = teeBox
            hole.name = ""
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





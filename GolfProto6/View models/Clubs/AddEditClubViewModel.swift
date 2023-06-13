//
//  AddEditClubViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import Foundation
import SwiftUI

class AddEditClubViewModel: ObservableObject {
    
    var name: String = ""
    var addressLine1: String = ""
    var addressLine2: String = ""
    var addressLine3: String = ""
    var addressLine4: String = ""
    var postCode: String = ""
//    var distMetric: Int = 0
    var eMail: String = ""
    var clubImage: UIImage = UIImage()
    
    @Published var pickerDistMetric: Int = 0
    
    func save() {
        
        func addRandomHoles(vm: TeeBox){
            func calcPar(distance: Int) -> Int {
                if distance <= 245 {return 3}
                if distance >= 465 {return 5}
                return 4
            }
            var strokeIndexes = Array(1...18)
            
            for i in 0...17 {
                let hole = Hole(context: CoreDataManager.shared.viewContext)
              
                hole.teeBox = vm
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
        
        
        
        let manager = CoreDataManager.shared
        let club = Club(context: manager.persistentContainer.viewContext)
        let course = Course(context: manager.persistentContainer.viewContext)
        let teeBox = TeeBox(context: manager.persistentContainer.viewContext)
        let teeBox1 = TeeBox(context: manager.persistentContainer.viewContext)
        let teeBox2 = TeeBox(context: manager.persistentContainer.viewContext)
        club.name = name
        club.addressLine1 = addressLine1
        club.addressLine2 = addressLine2
        club.addressLine3 = addressLine3
        club.addressLine4 = addressLine4
        club.postCode = postCode
        club.distMetric = Int16(pickerDistMetric)
        club.email = eMail
        club.clubImage = clubImage
        course.club = club
        course.name = "Original course"
        teeBox.course = course
        teeBox.colour = "White"
        teeBox.teeBoxColor = UIColor(.white)
        teeBox.courseRating = 70.0
        teeBox.slopeRating = 125
        teeBox1.course = course
        teeBox1.colour = "Yellow"
        teeBox1.teeBoxColor = UIColor(.yellow)
        teeBox1.courseRating = 69.0
        teeBox1.slopeRating = 122
        teeBox2.course = course
        teeBox2.colour = "Red"
        teeBox2.teeBoxColor = UIColor(.red)
        teeBox2.courseRating = 68.0
        teeBox2.slopeRating = 128
        addRandomHoles(vm: teeBox)
        addRandomHoles(vm: teeBox1)
        addRandomHoles(vm: teeBox2)
        manager.save()
    }

    
}

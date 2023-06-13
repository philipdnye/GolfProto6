//
//  AddPlayerViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 23/03/2023.
//

import Foundation
import SwiftUI

class AddPlayerViewModel: ObservableObject {
    var firstName: String = ""
    var lastName: String = ""
    var dateOfBirth: Date = Date()
    //var gender: String = ""
    var email: String = ""
    var mobile: String = ""
    var photo: UIImage = UIImage()
    var currentHandicap: String = ""
    var startDate: Date = Date()
    
    @Published var pickerGender: Int = 0
    
    func save() {
        let manager = CoreDataManager.shared
        let player = Player(context: manager.persistentContainer.viewContext)
        player.firstName = firstName
        player.lastName = lastName
        player.dateOfBirth = dateOfBirth
        player.gender = Int16(pickerGender)
        player.email = email
        player.mobile = mobile
        player.photo = photo
        
        let handicap = Handicap(context: manager.persistentContainer.viewContext)
        handicap.player = player
        handicap.startDate = startDate
        handicap.handicapIndex = Double(currentHandicap) ?? 0.0
        
        manager.save()
    }
    
}

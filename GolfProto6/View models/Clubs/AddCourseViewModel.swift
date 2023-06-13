//
//  AddCourseViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import Foundation

class AddCourseViewModel: ObservableObject {
    
    var name: String = ""
    
    
    func addCourseToClub(vm: ClubViewModel) {
        
        let club = CoreDataManager.shared.getClubById(id: vm.id)
        
        let course = Course(context: CoreDataManager.shared.viewContext)
        
        course.name = name
        course.club = club
        CoreDataManager.shared.save()
        
    }
    
    
    
}







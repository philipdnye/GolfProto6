//
//  CourseListViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import Foundation
import CoreData

class CourseListViewModel: ObservableObject {
    
    @Published var courses = [CourseViewModel]()
    
    func deleteCourse(course: CourseViewModel) {
        let course = CoreDataManager.shared.getCourseById(id: course.courseId)
        if let course = course {
            CoreDataManager.shared.deleteCourse(course)
        }
    }
    
    
    
    func getCoursesByClub(vm: ClubViewModel) {
        
        let club = CoreDataManager.shared.getClubById(id: vm.id)
        if let club = club {
            DispatchQueue.main.async {
                self.courses = (club.courses?.allObjects as! [Course]).map(CourseViewModel.init)
            }
        }
        
    }
}


struct CourseViewModel: Hashable {
    
    let course: Course
    
    var courseId: NSManagedObjectID {
        return course.objectID
    }
    
    var name: String {
        return course.name ?? ""
    }
    
}

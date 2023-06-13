//
//  TeeBoxListViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import Foundation
import CoreData
import SwiftUI

class TeeBoxListViewModel: NSObject, ObservableObject {

    @Published var teeBoxes = [TeeBoxViewModel]()
//    private var fetchedResultsController: NSFetchedResultsController<TeeBox>!

    func deleteTeeBox(teeBox: TeeBoxViewModel) {
        let teeBox = CoreDataManager.shared.getTeeBoxById(id: teeBox.teeBoxId)
        if let teeBox = teeBox {
            CoreDataManager.shared.deleteTeeBox(teeBox)
        }
    }
    
   
        
 

    
    
    
    func getTeeBoxesByCourse(vm: CourseViewModel) {

        let course = CoreDataManager.shared.getCourseById(id: vm.courseId)
        if let course = course {
            DispatchQueue.main.async {
                self.teeBoxes = (course.teeBoxes?.allObjects as! [TeeBox]).map(TeeBoxViewModel.init)
                
                
                    //.sorted(by: {$0.player.handicapHistory.currentHandicapIndex() < $1.player.handicapHistory.currentHandicapIndex()})
                
            }
        }

    }



}
//extension TeeBoxListViewModel: NSFetchedResultsControllerDelegate {
//
//}

struct TeeBoxViewModel: Hashable {

    let teeBox: TeeBox

    var teeBoxId: NSManagedObjectID {
        return teeBox.objectID
    }
    

    var colour: String {
        return teeBox.colour ?? ""
    }
    
    var courseRating: Double {
        return teeBox.courseRating
    }

    var slopeRating: Int16 {
        return teeBox.slopeRating
    }

    var teeBoxColor: UIColor {
   
        return teeBox.teeBoxColor ?? UIColor.clear
    }
    
    var totalDistance: Int16 {
        return {
            var total:Int16 = 0
            for hole in teeBox.holes! {
                total += (hole as AnyObject).distance
            }
            return total
        }()
    }
    var totalDistanceFront9: Int16 {
        return {
            var total:Int16 = 0
            for hole in teeBox.holes!.sorted(by: {($0 as AnyObject).number < ($1 as AnyObject).number}).prefix(9) {
                total += (hole as AnyObject).distance
            }
            return total
        }()
    }
    var totalDistanceBack9: Int16 {
        return {
            var total:Int16 = 0
            for hole in teeBox.holes!.sorted(by: {($0 as AnyObject).number < ($1 as AnyObject).number}).suffix(9) {
                total += (hole as AnyObject).distance
            }
            return total
        }()
    }
    var holes: [Hole] {
        return {
            var holes: [Hole] = []
            for hole in teeBox.holes!.sorted(by: {($0 as AnyObject).number < ($1 as AnyObject).number}) {
                holes.append(hole as! Hole)
            }
            return holes
        }()
    }
    var front9Holes: [Hole] {
        return {
            var holes: [Hole] = []
            for hole in teeBox.holes!.sorted(by: {($0 as AnyObject).number < ($1 as AnyObject).number}).prefix(9) {
                holes.append(hole as! Hole)
            }
            return holes
        }()
    }
    var back9Holes: [Hole] {
        return {
            var holes: [Hole] = []
            for hole in teeBox.holes!.sorted(by: {($0 as AnyObject).number < ($1 as AnyObject).number}).suffix(9) {
                holes.append(hole as! Hole)
            }
            return holes
        }()
    }
    
    
    
    var totalPar: Int16 {
        return {
            var total:Int16 = 0
            for hole in teeBox.holes! {
                total += (hole as AnyObject).par
            }
            return total
        }()
    }
    var totalParFront9: Int16 {
        return {
            var total:Int16 = 0
            for hole in teeBox.holes!.sorted(by: {($0 as AnyObject).number < ($1 as AnyObject).number}).prefix(9) {
                total += (hole as AnyObject).par
            }
            return total
        }()
    }
    var totalParBack9: Int16 {
        return {
            var total:Int16 = 0
            for hole in teeBox.holes!.sorted(by: {($0 as AnyObject).number < ($1 as AnyObject).number}).suffix(9) {
                total += (hole as AnyObject).par
            }
            return total
        }()
    }
    
}


//
//  ClubListViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import Foundation
import CoreData
import SwiftUI

class ClubListViewModel: NSObject, ObservableObject {
    
    @Published var clubs = [ClubViewModel]()
    @Published var clubs2 = [Club]()
    private var fetchedResultsController: NSFetchedResultsController<Club>!
    
    func deleteClub(club: ClubViewModel) {
        let club = CoreDataManager.shared.getClubById(id: club.id)
        if let club = club {
            CoreDataManager.shared.deleteClub(club)
        }
    }
    
    func getAllClubs1 () {
        let request: NSFetchRequest<Club> = Club.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        DispatchQueue.main.async {
            self.clubs = (self.fetchedResultsController.fetchedObjects ?? []).map(ClubViewModel.init)
        }

    }
    func getAllClubs2 () {
        let request: NSFetchRequest<Club> = Club.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        DispatchQueue.main.async {
            self.clubs2 = (self.fetchedResultsController.fetchedObjects ?? [])
        }

    }
    
    
    
    func getFirstClub () {
        let request: NSFetchRequest<Club> = Club.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      request.fetchLimit = 1
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        DispatchQueue.main.async {
            self.clubs = (self.fetchedResultsController.fetchedObjects ?? []).map(ClubViewModel.init)
        }

    }
   
    
    
    func getAllClubs() {
        
        let clubs = CoreDataManager.shared.getAllClubs()
        DispatchQueue.main.async {
            self.clubs = clubs.map(ClubViewModel.init)
        }
    }
}
extension ClubListViewModel: NSFetchedResultsControllerDelegate {
    
}

struct ClubViewModel: Hashable{
    
    let club: Club
    
    var id: NSManagedObjectID {
        return club.objectID
    }
    
    var name: String {
        return club.name ?? ""
    }
    
    var addressLine1: String {
        return club.addressLine1 ?? ""
    }
    var addressLine2: String {
        return club.addressLine2 ?? ""
    }
    var addressLine3: String {
        return club.addressLine3 ?? ""
    }
    var addressLine4: String {
        return club.addressLine4 ?? ""
    }
    var postCode: String {
        return club.postCode ?? ""
    }
    var eMail: String {
        return club.email ?? ""
    }
    
    var distMetric: Int16 {
        return club.distMetric
    }
    
    var clubImage: UIImage {
      
        return club.clubImage ?? UIImage()
        

    }
}





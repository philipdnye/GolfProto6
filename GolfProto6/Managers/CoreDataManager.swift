//
//  CoreDataManager.swift
//  GolfProto04
//
//  Created by Philip Nye on 21/04/2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: ObservableObject {
    
    // For showing the list of clubs
    @Published private(set) var clubs: [Club] = []
    
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    // For use with Xcode Previews, provides some data to work with for examples
    static var previewClub: CoreDataManager = {
        let coreDataManager = CoreDataManager(inMemory: true)
        
        let clubs = [
            "North Hants",
            "Wentworth",
            "Sunningdale",
            "Walton Heath"
        ]
        
        for club in clubs {
            coreDataManager.saveClubPreview(named: club)
        }
       
        // Now save these movies in the Core Data store
        do {
            try coreDataManager.persistentContainer.viewContext.save()
        } catch {
            // Something went wrong 😭
            print("Failed to save test clubs: \(error)")
        }

        return coreDataManager
        
        
    }()
    
    
    
    
    
   init(inMemory: Bool = false) {
        
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
        
        persistentContainer = NSPersistentCloudKitContainer(name: "GolfDataModel")
       
       
       
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
       persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
       persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
      
       
       // Don't save information for future use if running in memory...
       if inMemory {
           persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
       }
       
       
       
       
      
        
       
       // Attempt to load persistent stores (the underlying storage of data)
       persistentContainer.loadPersistentStores {(description, error) in
       
            if let error = error {
                fatalError("Failed to initialise Core Data \(error)")
            }else {
                
                print("Successfully loaded persistent stores.")
                
                // Get all the clubs
                self.clubs = self.getAllClubsPreview()
            }
        }
        
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    func getClubById(id: NSManagedObjectID) -> Club? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Club
        } catch {
            print(error)
            return nil
        }
    }
    
    func getHandicapById(id: NSManagedObjectID) -> Handicap? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Handicap
        } catch {
            print(error)
            return nil
        }
    }
    
    func getPlayerById(id: NSManagedObjectID) -> Player? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Player
        } catch {
            print(error)
            return nil
        }
    }
    

    
    func getCourseById(id: NSManagedObjectID) -> Course? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Course
        } catch {
            print(error)
            return nil
        }
    }
    
    func getTeeBoxById(id: NSManagedObjectID) -> TeeBox? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? TeeBox
        } catch {
            print(error)
            return nil
        }
    }
    func getHoleById(id: NSManagedObjectID) -> Hole? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Hole
        } catch {
            print(error)
            return nil
        }
    }
    
    func getGameById(id: NSManagedObjectID) -> Game? {
        do {
            return try
            persistentContainer.viewContext.existingObject(with: id) as? Game
        } catch {
            print(error)
            return nil
        }
    }
    
    func getCompetitorById(id: NSManagedObjectID) -> Competitor? {
        do {
            return try
            persistentContainer.viewContext.existingObject(with: id) as? Competitor
        } catch {
            print(error)
            return nil
        }
    }
    func getCompetitorScoreById(id: NSManagedObjectID) -> CompetitorScore? {
        do {
            return try
            persistentContainer.viewContext.existingObject(with: id) as? CompetitorScore
        } catch {
            print(error)
            return nil
        }
    }
    func getTeamScoreById(id: NSManagedObjectID) -> TeamScore? {
        do {
            return try
            persistentContainer.viewContext.existingObject(with: id) as? TeamScore
        } catch {
            print(error)
            return nil
        }
    }
    func getTeamShotsById(id: NSManagedObjectID) -> TeamShots? {
        do {
            return try
            persistentContainer.viewContext.existingObject(with: id) as? TeamShots
        } catch {
            print(error)
            return nil
        }
    }
    func getTeamTeeBoxById(id: NSManagedObjectID) -> TeamTeeBox? {
        do {
            return try
            persistentContainer.viewContext.existingObject(with: id) as? TeamTeeBox
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteClub(_ club: Club) {
        persistentContainer.viewContext.delete(club)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete club \(error)")
        }
    }
    
    func deleteHandicap(_ handicap: Handicap) {
        persistentContainer.viewContext.delete(handicap)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete handicap \(error)")
        }
    }
    
    func deletePlayer(_ player: Player) {
        persistentContainer.viewContext.delete(player)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete player \(error)")
        }
    }
    
    func deleteCourse(_ course: Course) {
        persistentContainer.viewContext.delete(course)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete course \(error)")
        }
    }
    
    func deleteTeeBox(_ teeBox: TeeBox) {
        persistentContainer.viewContext.delete(teeBox)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete teebox \(error)")
        }
    }
    
    func deleteGame(_ game: Game) {
        persistentContainer.viewContext.delete(game)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete game \(error)")
        }
    }
    func deleteCompetitor(_ competitor: Competitor) {
        persistentContainer.viewContext.delete(competitor)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete competitor \(error)")
        }
    }
    func deleteCompetitorScore(_ competitorScore: CompetitorScore) {
        persistentContainer.viewContext.delete(competitorScore)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete competitorScore \(error)")
        }
    }
    
    func deleteTeamScore(_ teamScore: TeamScore) {
        persistentContainer.viewContext.delete(teamScore)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete teamScore \(error)")
        }
    }
    
    func deleteTeamShots(_ teamShots: TeamShots) {
        persistentContainer.viewContext.delete(teamShots)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete teamShots \(error)")
        }
    }
    
    func deleteTeamTeeBox(_ teamTeeBox: TeamTeeBox) {
        persistentContainer.viewContext.delete(teamTeeBox)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete teamTeeBox \(error)")
        }
    }
    
    func getAllClubs() -> [Club] {
        
        let fetchRequest: NSFetchRequest<Club> = Club.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
            print("Data saved to core data")
        } catch {
            print("Failed to save MOC \(error)")
        }
    }
    
    
    
}
// Save a club
extension CoreDataManager {
    
    func saveClubPreview(named name: String) {
        
        func addRandomHoles(vm: TeeBox){
            func calcPar(distance: Int) -> Int {
                if distance <= 245 {return 3}
                if distance >= 465 {return 5}
                return 4
            }
            var strokeIndexes = Array(1...18)
            
            for i in 0...17 {
                let hole = Hole(context: persistentContainer.viewContext)
              
                hole.teeBox = vm
                hole.name = "hole name"
                hole.number = Int16(i+1)
                hole.distance = Int16.random(in: 110..<550)
                hole.par = Int16(calcPar(distance: Int(exactly: hole.distance)!))
                hole.strokeIndex = Int16(strokeIndexes.randomElement()!)
                
                let position = strokeIndexes.firstIndex(of: Int(exactly: hole.strokeIndex)!)
                strokeIndexes.remove(at: position!)
               
                do {
                    
                    // Persist the data in this managed object context to the underlying store
                    try persistentContainer.viewContext.save()
                    
                    print("Club saved successfully")
                    
                    // Refresh the list of movies
                    //movies = getAllMovies()
                    
                } catch {
                    
                    // Something went wrong 😭
                    print("Failed to save club: \(error)")
                    
                    // Rollback any changes in the managed object context
                    persistentContainer.viewContext.rollback()
                    
                }
                
                
            }
        }
        
        
        
        
        
        
        
        
        
        
        // New Movie instance is tied to the managed object context
        let club = Club(context: persistentContainer.viewContext)
        let course = Course(context: persistentContainer.viewContext)
        let teeBox = TeeBox(context: persistentContainer.viewContext)
        let teeBox1 = TeeBox(context: persistentContainer.viewContext)
        let teeBox2 = TeeBox(context: persistentContainer.viewContext)
        
        
        
        club.name = name
        club.addressLine1 = "Minley Road"
        club.addressLine2 = "Near station"
        club.addressLine3 = "Fleet"
        club.addressLine4 = "Hampshire"
        club.postCode = "GU51 5NP"
        club.distMetric = 1
        club.email = "philipdnye@me.com"
        club.clubImage = UIImage(named: "IMG_0791.jpeg")
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
        
        
        
        
        
        
        
        
        
        
        do {
            
            // Persist the data in this managed object context to the underlying store
            try persistentContainer.viewContext.save()
            
            print("Club saved successfully")
            
            // Refresh the list of movies
            //movies = getAllMovies()
            
        } catch {
            
            // Something went wrong 😭
            print("Failed to save club: \(error)")
            
            // Rollback any changes in the managed object context
            persistentContainer.viewContext.rollback()
            
        }
        
    }

}


// Get all the clubs
extension CoreDataManager {
    
    // Made private because views will access the movies retrieved from Core Data via the movies array in StorageProvider
    private func getAllClubsPreview() -> [Club] {
        
        // Must specify the type with annotation, otherwise Xcode won't know what overload of fetchRequest() to use (we want to use the one for the Club entity)
        // The generic argument <Club> allows Swift to know what kind of managed object a fetch request returns, which will make it easier to return the list of clubs as an array
        let fetchRequest: NSFetchRequest<Club> = Club.fetchRequest()
        
        do {
            
            // Return an array of Movie objects, retrieved from the Core Data store
            return try persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch {
            
            print("Failed to fetch clubs \(error)")
            
        }
        
        // If an error occured, return nothing
        return []
    }
    
}

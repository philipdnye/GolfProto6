//
//  PreviewProvider.swift
//  GolfProto05
//
//  Created by Philip Nye on 21/05/2023.
//

import Foundation
import CoreData

// Exists to provide a club to use with MovieDetailView and MovieEditView
extension Club {
    
    // Example movie for Xcode previews
    static var example: Club {
        
        // Get the first movie from the in-memory Core Data store
        let context = CoreDataManager.previewClub.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Club> = Club.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try? context.fetch(fetchRequest)
        
        return (results?.first!)!
    }
    
}

//
//  CompetitorScoreViewModel.swift
//  GolfProto04
//
//  Created by Philip Nye on 23/04/2023.
//

import Foundation
import CoreData

class CompetitorScoreListViewModel: ObservableObject {
    @Published var competitorScores = [CompetitorScoreViewModel]()
    
    func deleteCompetitorScore(competitorScore: CompetitorScoreViewModel) {
        let competitorScore = CoreDataManager.shared.getCompetitorScoreById(id: competitorScore.competitorScoreId)
        if let competitorScore = competitorScore {
            CoreDataManager.shared.deleteCompetitorScore(competitorScore)
        }
    }
    
    func getCompetitorScoresByCompetitor(vm: CompetitorViewModel) {
        
        let competitor = CoreDataManager.shared.getCompetitorById(id: vm.id)
        if let competitor = competitor {
            DispatchQueue.main.async {
                self.competitorScores = (competitor.scores?.allObjects as! [CompetitorScore]).map(CompetitorScoreViewModel.init)
            }
        }
        
    }
    
}

struct CompetitorScoreViewModel: Hashable {
    let competitorScore: CompetitorScore
    
    var competitorScoreId: NSManagedObjectID {
        return competitorScore.objectID
    }
    
    var distance: Int16 {
        return competitorScore.distance
    }
    
    var grossScore: Int16 {
        return competitorScore.grossScore
    }
    var committedGrossScore: Int16 {
        if self.committed{
            return self.grossScore
        } else {
            return 0
        }
    }
    
    
    var hole: Int16 {
        return competitorScore.hole
    }
    var par: Int16 {
        return competitorScore.par
    }
    
    var shotsRecdMatch: Int16 {
        return competitorScore.shotsRecdHoleMatch
    }
    var shotsRecdStroke: Int16 {
        return competitorScore.shotsRecdHoleStroke
    }
    var strokeIndex: Int16 {
        return competitorScore.strokeIndex
    }
    var committed: Bool {
        return competitorScore.scoreCommitted
    }
    
}

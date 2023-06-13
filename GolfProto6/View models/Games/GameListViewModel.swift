//
//  GameListViewModel.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import Foundation
import CoreData
import SwiftUI

class GameListViewModel: NSObject, ObservableObject {
    
    @Published var games = [GameViewModel]()
    @Published var competitors = [CompetitorViewModel]()
    
    private var fetchedResultsController: NSFetchedResultsController<Game>!
    private var fetchedResultsControllerCompetitor: NSFetchedResultsController<Competitor>!
    
    func deleteGame(game: GameViewModel){
        let game = CoreDataManager.shared.getGameById(id: game.id)
        if let game = game {
            CoreDataManager.shared.deleteGame(game)
        }
    }
    
    func deleteCompetitor(competitor: Competitor) {
        let competitor = CoreDataManager.shared.getCompetitorById(id: competitor.objectID)
        if let competitor = competitor {
            CoreDataManager.shared.deleteCompetitor(competitor)
        }
    }
    
    func getAllGames () {
        let request: NSFetchRequest<Game> = Game.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        DispatchQueue.main.async {
            self.games = (self.fetchedResultsController.fetchedObjects ??
            
                          []).map(GameViewModel.init)
        }
    }
    
    
    func FilterScoreFormats(pickedGameFormatID: Int) -> [ScoreFormat] {
        //        creates an array of ScoringFormats permitted by the picked GameFormat
        var filteredScoreFormats = ScoreFormat.allCases
        let pickedGameFormat = gameFormats.filter({$0.id == pickedGameFormatID})[0]
        if pickedGameFormat.medal == false {
            let firstIndex = filteredScoreFormats.firstIndex(where: {$0 == ScoreFormat.medal})
            filteredScoreFormats.remove(at: firstIndex ?? 0)
        }
        if pickedGameFormat.stableford == false {
            let firstIndex = filteredScoreFormats.firstIndex(where: {$0 == ScoreFormat.stableford})
            filteredScoreFormats.remove(at: firstIndex ?? 0)
        }
        if pickedGameFormat.bogey == false {
            let firstIndex = filteredScoreFormats.firstIndex(where: {$0 == ScoreFormat.bogey})
            filteredScoreFormats.remove(at: firstIndex ?? 0)
        }
        return filteredScoreFormats
    }
    
    
    func getAllCompetitors () {
        let request: NSFetchRequest<Competitor> = Competitor.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "handicapIndex", ascending: false)]
        fetchedResultsControllerCompetitor = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsControllerCompetitor.delegate = self
        try? fetchedResultsControllerCompetitor.performFetch()
        DispatchQueue.main.async {
            self.competitors = (self.fetchedResultsControllerCompetitor.fetchedObjects ??
            
                          []).map(CompetitorViewModel.init)
        }
    }
    
    func updateCurrentGameFormat (currentGF: CurrentGameFormat, game: Game) {
        currentGF.id = gameFormats[Int(game.gameFormat)].id
        currentGF.format = gameFormats[Int(game.gameFormat)].format
        currentGF.description = gameFormats[Int(game.gameFormat)].description
        currentGF.noOfPlayersNeeded = gameFormats[Int(game.gameFormat)].noOfPlayersNeeded
        currentGF.playerHandAllowances = gameFormats[Int(game.gameFormat)].playerHandAllowances
        currentGF.assignShotsRecd = gameFormats[Int(game.gameFormat)].assignShotsRecd
        currentGF.assignTeamGrouping = gameFormats[Int(game.gameFormat)].assignTeamGrouping
        currentGF.competitorSort = gameFormats[Int(game.gameFormat)].competitorSort
        currentGF.playFormat = gameFormats[Int(game.gameFormat)].playFormat
        currentGF.extraShotsTeamAdj = gameFormats[Int(game.gameFormat)].extraShotsTeamAdj
        currentGF.bogey = gameFormats[Int(game.gameFormat)].bogey
        currentGF.medal = gameFormats[Int(game.gameFormat)].medal
        currentGF.stableford = gameFormats[Int(game.gameFormat)].stableford

    }
    
    
   
    
}


extension GameListViewModel: NSFetchedResultsControllerDelegate {
    
}


struct GameViewModel: Hashable {
    
    let game: Game
    
    var id: NSManagedObjectID {
        return game.objectID
    }
    
    var name: String {
        return game.name ?? ""
    }
    
    var date: Date {
        return game.date ?? Date()
    
    }
    
    var gameStarted: Bool {
        return game.started
    }
    
    var gameFinished: Bool {
        return game.finished
    }
    
    var startTime: Date {
        return game.startTime ?? Date()
    }
    var finishTime: Date {
        return game.finishTime ?? Date()
    }
    var startingHole: Int16 {
        return game.startingHole
    }
    
    var startingHoleString: String {
        switch self.startingHole{
        
        case 2:
            return "2nd"
        case 3:
            return "3rd"
        case _ where self.startingHole > 3 || self.startingHole < 19 && self.startingHole > 3:
            return "\(self.startingHole)th"

        default:
            return "1st"
        }
    }
    
    
//    var club: Club {
//        return game.club ?? Club(context: CoreDataManager.shared.persistentContainer.viewContext)
//        
//    }
    
    var defaultTeeBox: TeeBox {
        return game.defaultTeeBox ?? TeeBox(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
    
//    var defaultCourse: Course {
//        return game.defaultCourse ?? Course(context: CoreDataManager.shared.persistentContainer.viewContext)
//    }
    var defaultTeeBoxColour: String {
        return game.defaultTeeBox?.wrappedColour ?? ""
    }
    
    var courseName: String {
        return game.defaultTeeBox?.course?.name ?? ""
    }
    
    var clubName: String {
        return game.defaultTeeBox?.course?.club?.wrappedName ?? ""
    }
    var scoreFormatName: String {
        return game.sc_format.stringValue()
    }
    var gameFormatName: String {
        game.game_format.Succint_Description()
    }
    var handicapFormatName: String {
        game.hcap_format.stringValue()
    }
    
    
    var succinctDescription: String {
        return game.game_format.Succint_Description()
    }
    
    var durationName: String {
        return game.game_duration.stringValue()
    }
    
    var duration: Int16 {
        return game.duration
    }
    
    var gameFormat: Int16 {
        return game.gameFormat
    }
    
    var playFormat: Int16 {
        return game.playFormat
    }
    
    var scoreFormat: Int16 {
        return game.scoreFormat
    }
    
    
}


struct CompetitorViewModel: Hashable {
    let competitor: Competitor
   
    var id: NSManagedObjectID {
        return competitor.objectID
    }
    var handicapIndex: Double {
        return competitor.handicapIndex
    }
    var playingHandicap: Double {
        return competitor.playingHandicap
    }
    var courseHandicap: Double {
        return competitor.courseHandicap
    }
    var player: Player {
        return competitor.player ?? Player(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
    var teeBox: TeeBox {
        return competitor.teeBox ?? TeeBox(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
    var game: Game {
        return competitor.game ?? Game(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
    
    var playerFirstName: String {
        return competitor.player?.firstName ?? ""
    }
    var playerLastName: String {
        return competitor.player?.lastName ?? ""
    }
    
    var teeBoxColour: String {
        return competitor.teeBox?.wrappedColour ?? ""
    }
    var teeboxSlopeRating: Int {
        return Int(competitor.teeBox?.slopeRating ?? 120)
    }
    var teeboxCourseRating: Double {
        return Double(competitor.teeBox?.courseRating ?? 70.0)
    }
    
    
}

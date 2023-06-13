//
//  GameDetailScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct GameDetailScreen: View {
    @StateObject private var addGameVM = AddGameViewModel()
    @StateObject private var gameListVM = GameListViewModel()
    @StateObject private var startGameVM = StartGameViewModel()
    @EnvironmentObject var currentGF: CurrentGameFormat
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @State private var isPresented: Bool = false
    @State private var isPresentedHcap: Bool = false
    @State private var needsRefresh: Bool = false
    
    @State private var isShowingDialogueTrash:Bool = false
    @State private var isShowingDialogueScoreEntry:Bool = false
    //@State private var showingSheetScorecard: Bool = false
    //@State private var gotoScoreEntry: Bool = false
    @State private var showingSheetHandicapCalc: Bool = false
    @State private var isPresentedGameTeeBox: Bool = false
    @State private var isShowingScoreEntryScreen: Bool = false
    
    func OnAppear() {
        gameListVM.getAllGames()

        gameListVM.updateCurrentGameFormat(currentGF: currentGF, game: game.game)

    }
    private func onAdd() {
        
        isPresented.toggle()
    }
    
    private func onAddHcap() {
        
        isPresentedHcap.toggle()
    }
    private func UpdateCompetitorTeam(competitor: Competitor, value: Int16) {
        let manager = CoreDataManager.shared
        let competitorId = competitor.objectID
        let currentCompetitor = manager.getCompetitorById(id: competitorId)
        currentCompetitor?.team = value
        manager.save()
        needsRefresh.toggle()
        gameListVM.getAllGames()
        gameListVM.getAllCompetitors()
    }
    
    
    private var gotoScoreEntryButton: some View {
        
        AnyView(Button(action: GotoScoreEntryScreen){
            if game.game.started == false {
                Text("Start game")
            } else {
                Text("Resume game")
            }
        })
    }
    
    
    
    
    private func GotoScoreEntryScreen() {
        
        // if a new game can go straight to empty scorecards
        if game.game.started == false {
            isShowingDialogueScoreEntry.toggle()
           // if game already started need to reload the default values
        } else {
            scoreEntryVM.currentGame = game
            switch currentGF.assignShotsRecd {
            case .Indiv:
                scoreEntryVM.loadCompetitorsScore(currentGF: currentGF) // if game has already started just reload the competitor scores, as default values will have already been set up
            case .TeamsAB:
                scoreEntryVM.loadTeamScore()
            case .TeamC:
                scoreEntryVM.loadTeamCScore()
            }
            isShowingScoreEntryScreen = true
        }
        
    }
    
    
    
    
    
    
    
    
    private var scoreEntryButton: some View {
        AnyView(Button(action: showScoreEntry){
//            let CGI = games.allGames.firstIndex(where: {$0 == game}) ?? 0
            if game.gameStarted == true {
                
                switch game.gameFinished {
                case false:
                    Text("Resume game")
                case true:
                    Text("Scorecard")
                }
            } else {
                
                Text("Start game")
               
            }
            
            
        })//{Image(systemName: "list.number")})
    }
    
    private func showScoreEntry() {

        if game.gameStarted == false {
            isShowingDialogueScoreEntry.toggle()
        } else {
            
            switch game.gameFinished {
            case true:
                break
                //code here to launch the scorecard
                
                //showingSheetScorecard.toggle()
            case false:
                break
                //gotoScoreEntry.toggle()
            }
        }
    }
    
    private var handicapCalcButton: some View {
        AnyView(Button(action: showHandicapCalc){
            Image(systemName: "h.circle")
                .foregroundColor(darkTeal)
            
        })
    }
    
    private func showHandicapCalc() {
        showingSheetHandicapCalc.toggle()
    }
    private var trashButton: some View {
       
        AnyView(Button(action: deleteGame){Image(systemName: "trash")})
            
    }
    
    private func deleteGame() {
//        let CGI = games.allGames.firstIndex(where: {$0 == game}) ?? 0
//        if games.allGames[CGI].gameStarted != true {
            isShowingDialogueTrash = true
//        }
    }
    
    
    private var teamPlayingHandicaps: some View {
        Group{
            switch currentGF.assignShotsRecd {
            case .Indiv:
               EmptyView()
            case .TeamsAB:
            TeamsABPlayingHandicaps(needsRefesh: $needsRefresh,game: game)
            case .TeamC:
                TeamCPlayingHandicap(needsRefresh: $needsRefresh ,game: game)
               
            }
        }
    }
    
    private var teamShotsReceived: some View {
        Group{
            switch currentGF.assignShotsRecd {
            case .Indiv:
                EmptyView()
            case .TeamsAB:
                TeamsABShotsReceived(needsRefresh: $needsRefresh ,game: game)
            case .TeamC:
                EmptyView()
            }
        }
    }
    
    
    let game: GameViewModel
    
    var body: some View {
    
            VStack(alignment: .leading, spacing: 0){
                //            Text(needsRefresh.description)
                GameSummaryForDetailScreen(game: game)
                
                teamPlayingHandicaps
                teamShotsReceived
          
                
                if
                    currentGF.assignTeamGrouping == .TeamsAB && currentGF.assignShotsRecd == .TeamsAB && game.game.TeeBoxesAllSame() == false && game.gameStarted == false ||
                        currentGF.assignTeamGrouping == .TeamC && currentGF.assignShotsRecd == .TeamC && game.game.TeeBoxesAllSame() == false && game.gameStarted == false
                {
                    HStack{
                        Text(game.game.diffTeesTeeBox?.wrappedColour ?? "")
                        Button("Select teeBox"){
                            isPresentedGameTeeBox.toggle()
                        }
                    }
                }
                
                Form{
                    Section {
                        
                        ForEach(game.game.SortedCompetitors(currentGF: currentGF), id: \.self){competitor in
                            CompetitorRowItem_GameDetail(competitor: competitor,game: game ,needsRefresh: $needsRefresh)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false){
                                    Button{
                                        currentGF.swipedCompetitor = competitor
                                        onAdd()
                                    } label: {
                                        Text("TeeBox")
                                    }
                                    .tint(.mint)
                                    .disabled(game.gameStarted)
                                }
                            
                                .swipeActions(edge: .trailing, allowsFullSwipe: false){
                                    Button{
                                        currentGF.swipedCompetitor = competitor
                                        onAddHcap()
                                    } label: {
                                        Label("Handicap calculation",systemImage: "h.circle")
                                    }
                                    .tint(darkTeal)
                                }
                            
                            
                                .swipeActions(edge: .leading,allowsFullSwipe: false) {
                                    Button {
                                        UpdateCompetitorTeam(competitor: competitor, value: 1)
                                        
                                        addGameVM.AssignHandicapsAndShots(game: game.game, currentGF: currentGF)
                                        
                                        needsRefresh.toggle()
                                        gameListVM.getAllGames()
                                        gameListVM.getAllCompetitors()
                                        
                                        
                                        
                                        print(game.game.competitorArray.filter{$0.team == 1}.count)
                                    } label: {
                                        Label("Swap team",systemImage: "a.circle")
                                    }
                                    .tint(.gray)
                                    
                                    .disabled(competitor.team == TeamAssignment.teamA.rawValue || currentGF.assignTeamGrouping != Assignment.TeamsAB || game.game.competitorArray.filter{$0.team == 1}.count > 2 || game.gameStarted)
                                    
                                }
                                .swipeActions(edge: .leading,allowsFullSwipe: false) {
                                    Button {
                                        UpdateCompetitorTeam(competitor: competitor, value: 2)
                                        addGameVM.AssignHandicapsAndShots(game: game.game, currentGF: currentGF)
                                        //
                                        needsRefresh.toggle()
                                        gameListVM.getAllGames()
                                        gameListVM.getAllCompetitors()
                                        
                                        
                                        print(game.game.competitorArray.filter{$0.team == 2}.count)
                                    } label: {
                                        Label("Swap team",systemImage: "b.circle")
                                    }
                                    .tint(.blue)
                                    
                                    .disabled(competitor.team == TeamAssignment.teamB.rawValue || currentGF.assignTeamGrouping != Assignment.TeamsAB || game.game.competitorArray.filter{$0.team == 2}.count > 2 || game.gameStarted)
                                    
                                }
                           
                            
                        }
                    } //section
                header: {
                    
                    Text("Players in this game")
                } footer: {
                    if game.gameStarted == false {
                        VStack{
                            Text("Swipe LEFT to change the players teebox")
                            Text("Swipe RIGHT to assign TEAMS")
                        }
                    }
                }
                }
                
            }//vstack
            
        
        
        
        
        
        
                       .navigationDestination(isPresented: $isShowingScoreEntryScreen) {
                           ScoreEntryScreen(game: game)
                               .toolbar(.hidden, for: .tabBar)
                      }
        
            .sheet(isPresented: $isPresented, onDismiss: {
                gameListVM.getAllGames()
                
            }, content: {
                ChangeCompetitorTeeBoxSheet(competitor: currentGF.swipedCompetitor, game: game, isPresented: $isPresented, neeedsRefresh: $needsRefresh)
                    .presentationDetents([.fraction(0.25)])
            })
            
            .sheet(isPresented: $isPresentedHcap, onDismiss: {
                
            }, content: {
                CourseHandicapCalcScreen(isPresentedHcap: $isPresentedHcap, competitor: currentGF.swipedCompetitor)
                    .presentationDetents([.fraction(0.4)])
            })
            
            .sheet(isPresented: $isPresentedGameTeeBox, onDismiss: {
                gameListVM.getAllGames()
                
            }, content: {
                ChangeMatchTeeBoxSheet(game: game, isPresentedGameTeeBox: $isPresentedGameTeeBox, neeedsRefresh: $needsRefresh)
                    .presentationDetents([.fraction(0.25)])
            })
            
            
        
            .confirmationDialog("Start game", isPresented: $isShowingDialogueScoreEntry, actions: {
                Button("Start game", role: .destructive){
                    startGameVM.StartGame(game: game.game, currentGF: currentGF)
                    scoreEntryVM.currentGame = game // this is used in score entry screen
                    //need code here to load up defualt values for each competitor OR team
                    
                    switch currentGF.assignShotsRecd {
                    case .Indiv:
                        scoreEntryVM.assignDefaultValues(currentGF: currentGF)
                    case .TeamsAB:
                        scoreEntryVM.assignDefaultValuesTeams()
                    case .TeamC:
                        scoreEntryVM.assignDefaultValuesTeamC()
                    }
                    
                    isShowingScoreEntryScreen = true
                }
                
            }, message: {Text("If you start this game, you will not be able to amend any settings. Are you sure you want to continue?")})
        
        
            .onAppear(perform: {
                OnAppear()
            })
            
//            .confirmationDialog(
//                "If you start this game, you will not be able to amend any settings. Are you sure you want to continue?",
//                isPresented: $isShowingDialogueScoreEntry
//            ) {
//                // Button("Start game", role: .destructive) {
//                Button {
//
//
//
//
//                    startGameVM.StartGame(game: game.game, currentGF: currentGF)
//
//
//                    self.isShowingDetailView = true
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Text("Start game1")
//                }
                
                
                    
//                }
//            .navigationDestination(isPresented: $isShowingDetailView){
//                ScoreEntryScreen(game: game))
                
                //                print(game.clubName)
                //                print(game.courseName)
                //                print(game.game.distMetric)
                //
                //                if currentGF.assignShotsRecd == .Indiv {
                //
                //                    print(game.game.competitorArray[0].firstName ?? "")
                //                    print(game.game.competitorArray[0].lastName ?? "")
                //                    print(game.game.competitorArray[0].teeBoxColour ?? "")
                //                    print(game.game.competitorArray[0].slopeRating)
                //                    print(game.game.competitorArray[0].courseRating)
                //                    print(game.game.competitorArray[0].handicapIndex)
                //                    print(game.game.competitorArray[0].handicapAllowance)
                //                    print(game.game.competitorArray[0].courseHandicap)
                //                    print(game.game.competitorArray[0].playingHandicap)
                //                    print(game.game.competitorArray[0].diffTeesXShots)
                //                    print(game.game.competitorArray[0].shotsRecdMatch)
                //
                //
                //                    print(game.game.competitorArray[0].competitorScoresArray[0].distance)
                //                    print(game.game.competitorArray[0].competitorScoresArray[1].distance)
                //                    print(game.game.competitorArray[0].competitorScoresArray[2].distance)
                //
                //                    print(game.game.competitorArray[1].firstName ?? "")
                //                    print(game.game.competitorArray[1].lastName ?? "")
                //                    print(game.game.competitorArray[1].teeBoxColour ?? "")
                //                    print(game.game.competitorArray[1].slopeRating)
                //                    print(game.game.competitorArray[1].courseRating)
                //                    print(game.game.competitorArray[1].handicapIndex)
                //                    print(game.game.competitorArray[1].handicapAllowance)
                //                    print(game.game.competitorArray[1].courseHandicap)
                //                    print(game.game.competitorArray[1].playingHandicap)
                //                    print(game.game.competitorArray[1].diffTeesXShots)
                //                    print(game.game.competitorArray[1].shotsRecdMatch)
                //
                //
                //                    print(game.game.competitorArray[1].competitorScoresArray[0].distance)
                //                    print(game.game.competitorArray[1].competitorScoresArray[1].distance)
                //                    print(game.game.competitorArray[1].competitorScoresArray[2].distance)
                //
                //
                //                    print(game.game.competitorArray[2].firstName ?? "")
                //                    print(game.game.competitorArray[2].lastName ?? "")
                //                    print(game.game.competitorArray[2].teeBoxColour ?? "")
                //                    print(game.game.competitorArray[2].slopeRating)
                //                    print(game.game.competitorArray[2].courseRating)
                //                    print(game.game.competitorArray[2].handicapIndex)
                //                    print(game.game.competitorArray[2].handicapAllowance)
                //                    print(game.game.competitorArray[2].courseHandicap)
                //                    print(game.game.competitorArray[2].playingHandicap)
                //                    print(game.game.competitorArray[2].diffTeesXShots)
                //                    print(game.game.competitorArray[2].shotsRecdMatch)
                //
                //
                //                    print(game.game.competitorArray[2].competitorScoresArray[0].distance)
                //                    print(game.game.competitorArray[2].competitorScoresArray[1].distance)
                //                    print(game.game.competitorArray[2].competitorScoresArray[2].distance)
                //
                //
                //
                //                    for j in 0..<game.game.competitorArray.count {
                //                        print(game.game.competitorArray[j].firstName ?? "")
                //                        for i in 0..<18 {
                //                            print(game.game.competitorArray[j].competitorScoresArray[i].shotsRecdHoleMatch)
                //                        }
                //
                //                    }
                //
                //                    for j in 0..<game.game.competitorArray.count {
                //                        print(game.game.competitorArray[j].firstName ?? "")
                //                        for i in 0..<18 {
                //                            print(game.game.competitorArray[j].competitorScoresArray[i].shotsRecdHoleStroke)
                //                        }
                //
                //                    }
                //
                //                }
                //
                //
                //                for j in 0..<18 {
                //                    print(game.game.teamScoresArray[j].distance)
                //                }
                //                for j in 0..<18 {
                //                    print(game.game.teamScoresArray[j].shotsRecdHoleStroke)
                //                }
                //                for j in 0..<18 {
                //                    print(game.game.teamScoresArray.filter({$0.team == 0})[j].distance)
                //                }
                
                
                //gotoScoreEntry.toggle()
                //}
                
                
                
                
                
                
//            } message: {
//                Text("If you start this game, you will not be able to amend any settings. Are you sure you want to continue?")
//            }
            
//            .confirmationDialog(
//                "Permanently delete this game?",
//                isPresented: $isShowingDialogueTrash
//            ) {
//                Button("Delete game", role: .destructive) {
//                    //                            let index = games.allGames.firstIndex(where: {$0 == game}) ?? 0
//                    //                                games.allGames[scoreEntryVar.CGI].deleted = true
//                    //                                games.saveGamesFM()
//
//                    self.presentationMode.wrappedValue.dismiss()
//                }
//            } message: {
//                Text("You cannot undo this action.")
//            }
            
            
            
            .navigationBarItems(
                leading:trashButton,
                trailing: HStack{
                    handicapCalcButton
                    gotoScoreEntryButton
                }
            )
            
            
            
        }
    
}

struct GameDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        GameDetailScreen(game:game)
            .environmentObject(CurrentGameFormat())
            .environmentObject(ScoreEntryViewModel())
    }
}

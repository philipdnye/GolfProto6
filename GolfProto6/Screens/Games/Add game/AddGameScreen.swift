//
//  TestViewClubArray.swift
//  GolfProto03
//
//  Created by Philip Nye on 15/04/2023.
//

import SwiftUI





struct AddGameScreen: View {
    @StateObject private var gameListVM = GameListViewModel()
    @StateObject private var clubListVM = ClubListViewModel()
    @StateObject private var addGameVM = AddGameViewModel()
    @StateObject private var playerListVM = PlayerListViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var currentGF: CurrentGameFormat
    @FocusState private var AddGameViewInFocus: AddGameViewFocusable?
 
    

   private func createGame () {

       let manager = CoreDataManager.shared
       let game = Game(context: manager.persistentContainer.viewContext)
       
       game.name = addGameVM.name
       game.date = addGameVM.date
       game.defaultTeeBox = clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.getElement(at: addGameVM.pickedCourse)?.teeBoxArray.getElement(at: addGameVM.pickedTeeBox) ?? TeeBox()
       game.gameFormat = Int16(addGameVM.pickerGameFormat.rawValue)
       game.duration = Int16(addGameVM.pickerGameDuration)
       game.startingHole = Int16(addGameVM.pickerStartingHole)
       
           for player in playerListVM.players.filter({$0.selectedForGame == true}) {
               let competitor = Competitor(context: manager.persistentContainer.viewContext)
               competitor.player = player.player
               competitor.game = game
               competitor.teeBox = game.defaultTeeBox
               competitor.handicapIndex = player.player.handicapArray.currentHandicapIndex()
               competitor.courseHandicap = competitor.CourseHandicap()
               player.player.selectedForGame.toggle()
           }
      
       game.scoreFormat = Int16(addGameVM.pickerScoringFormat.rawValue)
       game.handicapFormat = Int16(addGameVM.pickerHandicapFormat.rawValue)
       // put a placeholer teebox as the default teebox where teams need to manually select the teebox when playing off different tees
       
       game.diffTeesTeeBox = game.defaultTeeBox
       
       manager.save()

       gameListVM.updateCurrentGameFormat(currentGF: currentGF, game: game)
       // code here to create an instance of TeamShots, for each team, if handicaps allocated by team
      
       if currentGF.assignShotsRecd == .TeamsAB || currentGF.assignShotsRecd == .TeamC {
           let teamShotsA = TeamShots(context: manager.persistentContainer.viewContext)
           let teamShotsB = TeamShots(context: manager.persistentContainer.viewContext)
           let teamShotsC = TeamShots(context: manager.persistentContainer.viewContext)
           teamShotsA.game = game
           teamShotsB.game = game
           teamShotsC.game = game
           
           teamShotsA.team = 1
           teamShotsB.team = 2
           teamShotsC.team = 3
           
           //teamShotsA.playingHandicap = 37
           
           
           manager.save()
           
           //           if !game.teamShotsArray.isEmpty {
           //               print(game.teamShotsArray[0].playingHandicap)
           //               print(game.teamShotsArray[0].team)
           //           }
           
           
       }
       
       //code here to assign competitor teams
       
       addGameVM.AssignCompetitorTeams(game: game, currentGF: currentGF)
       addGameVM.AssignHandicapsAndShots(game: game, currentGF: currentGF)

       presentationMode.wrappedValue.dismiss()
       
    }
    

    
    private func togglePlayerSelected (player: PlayerViewModel) {
        let manager = CoreDataManager.shared
        let selectedPlayer = manager.getPlayerById(id: player.id)
        selectedPlayer?.selectedForGame.toggle()
       
        manager.save()
        playerListVM.getAllPlayers()
        
        // need code here to not only determine default format for selected no of players,
        // but also forces a value into the picker
        
        switch playerListVM.players.filter({$0.selectedForGame == true}).count {
        case 1:
            addGameVM.pickerGameFormat = .noneOnePlayer
        case 2:
            addGameVM.pickerGameFormat = .singlesMatchplay
        case 3:
            addGameVM.pickerGameFormat = .sixPoint
        case 4:
            addGameVM.pickerGameFormat = .fourBallBBMatch
        default:
            addGameVM.pickerGameFormat = .noFormat
        }
        
        //need a function to calculate the players course handicap
    }
    
    var body: some View {
      
//        let currentGF = CurrentGameFormat()
       
       
        Form{
            Section{
                TextField("Enter name for this game",text: $addGameVM.name)

                    .keyboardType(.default)
                    .focused($AddGameViewInFocus, equals: .name)

                DatePicker(selection: $addGameVM.date, in: ...Date(),displayedComponents: .date) {
                    Text("Game played on: ")


                }
                .focused($AddGameViewInFocus, equals: .date)

                Picker("Select club", selection: $addGameVM.pickedClub) {
                    ForEach(0..<clubListVM.clubs2.count, id: \.self){
                        Text(clubListVM.clubs2[$0].wrappedName)
                            .tag($0)
                            .focused($AddGameViewInFocus, equals: .club)
                    }
                }



                Picker("Select course", selection: $addGameVM.pickedCourse) {
                    ForEach(0..<(clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.count ?? 0), id: \.self){
                        Text(clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.getElement(at: $0)?.name ?? "")
                            .tag($0)
                            .focused($AddGameViewInFocus, equals: .course)
                    }
                }

                Picker("Default tees for game", selection: $addGameVM.pickedTeeBox){
                    ForEach(0..<(clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.getElement(at: addGameVM.pickedCourse)?.teeBoxArray.count ?? 0), id: \.self){
                        Text(clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.getElement(at: addGameVM.pickedCourse)?.teeBoxArray.getElement(at: $0)?.wrappedColour ?? "")
                            .tag($0)
                            .focused($AddGameViewInFocus, equals: .teebox)
                    }
                }
                
                Picker("Game duration", selection: $addGameVM.pickerGameDuration){
                    ForEach(GameDuration.allCases, id: \.self){
                        Text($0.stringValue())
                            .tag($0.rawValue)
                    }
                }
                
                Picker("Starting hole", selection: $addGameVM.pickerStartingHole){
                    ForEach(1..<19){
                        Text($0.formatted())
                            .tag($0)
                    }
                }
                
                
                
            }
            Section {
                
                ForEach(playerListVM.players.filter({$0.selectedForGame == true}), id: \.self){player in
                    AddGamePlayerRowItem(player: player)

                    .swipeActions(allowsFullSwipe: true) {
                    
                    Button {
                        togglePlayerSelected(player: player)
                        
                      
                } label: {
                Label("Mute", systemImage: "person.fill.badge.minus")
            }
            .tint(.red)
                    
                    
                                                }
                }
                
            }
            
        header: {
            
            Text("PLAYERS ADDED TO THE GAME")
                .foregroundColor(.orange)
        } footer: {
            Text("Remove players by swiping to the left.")
                .foregroundColor(.orange)
                
            
        }
    
            Section {
         
                ForEach(playerListVM.players.filter({$0.selectedForGame == false}), id: \.self){player in
                    AddGamePlayerRowItem(player: player)

                    .swipeActions(allowsFullSwipe: true) {
                    
                    Button {
                        togglePlayerSelected(player: player)
                        
                      
                } label: {
                Label("Mute", systemImage: "person.fill.badge.plus")
            }
            .tint(.indigo)
                    
                    
                                                }
                }
                
           
            
        }
    header: {
        Text("AVAILABLE PLAYERS")
            .foregroundColor(.green)
    }
    footer: {
        Text("Add players by swiping to the left.")
            .foregroundColor(.green)
    }
            
            Section{
                
           let playerCount = playerListVM.players.filter({$0.selectedForGame == true}).count
                    
                    
                
                
                let filteredGameFormats = GameFormatType.allCases.filter({$0.NoOfPlayers() == playerCount})
                
                
                Picker("Game", selection: $addGameVM.pickerGameFormat){
                    ForEach(filteredGameFormats.sorted(by: {
                        $0.rawValue < $1.rawValue
                    }), id: \.self) {gameFormat in
                        Text(gameFormat.stringValue())
                            .tag(gameFormat)
                    }
                }

         
                
                let filteredScoringFormats = gameListVM.FilterScoreFormats(pickedGameFormatID: addGameVM.pickerGameFormat.rawValue)

                
                Picker("Score format", selection:$addGameVM.pickerScoringFormat){
                    ForEach(filteredScoringFormats, id: \.self){format in
                        
                        Text(format.stringValue())
                            .tag(format)
                    }
                }
                Picker("Handicap",selection: $addGameVM.pickerHandicapFormat){
                    ForEach(HandicapFormat.allCases, id: \.self){format in
                        Text(format.stringValue())
                            .tag(format)
                        
                    }
                }

                
            }
            Section {
                HStack{
                    Spacer()
                    Button("Create game"){
                        createGame()
                    }
                    //.disabled(playerCount == 0)
                    Button("Dismiss"){
                        for player in playerListVM.players.filter({$0.selectedForGame == true}) {
                         
                            player.player.selectedForGame.toggle()
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
            }
            
        }
        
        .onAppear(perform: {

            clubListVM.getAllClubs2()
            playerListVM.getAllPlayers()

        })
        
        .onSubmit {

            if AddGameViewInFocus == .name {
                AddGameViewInFocus = .date
            } else if AddGameViewInFocus == .date {
                AddGameViewInFocus = .club
            } else if AddGameViewInFocus == .club {
                AddGameViewInFocus = .course
            } else if AddGameViewInFocus == .course {
                AddGameViewInFocus = .teebox

            }
        }
        .interactiveDismissDisabled()
    }
}





struct AddGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddGameScreen()
            .environmentObject(CurrentGameFormat())
    }
}

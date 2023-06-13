//
//  ChangeMatchTeeBoxSheet.swift
//  GolfProto04
//
//  Created by Philip Nye on 24/04/2023.
//

import SwiftUI

struct ChangeMatchTeeBoxSheet: View {
    @StateObject private var addGameVM = AddGameViewModel()
    @EnvironmentObject var currentGF: CurrentGameFormat
    
    let game: GameViewModel
    @Binding var isPresentedGameTeeBox: Bool
    @Binding var neeedsRefresh: Bool
    
    var body: some View {
        Form{
            
            
            
            Section{
                Picker("Select teebox for game", selection: $addGameVM.newTeeBoxForGame) {
                    ForEach(game.game.defaultTeeBox?.course?.teeBoxArray ?? [], id: \.self){
                        Text($0.wrappedColour)
                            .tag($0)
                            //.pickerStyle(.segmented)
                    }
                   
                }
                HStack{
                    Spacer()
                    Button("Confirm new teebox"){
                        
                        game.game.diffTeesTeeBox = addGameVM.newTeeBoxForGame
                        let manager = CoreDataManager.shared
                        manager.save()
//
//
                        isPresentedGameTeeBox = false
                        neeedsRefresh.toggle()
                    }
                    Spacer()
                }
            }
        header: {
                 Text("Change teebox for this game")
//            HStack{
//                Text(competitor.FirstName().capitalized)
//                Text(competitor.LastName().capitalized)
//            }
                 }
//        footer: {
//
//                     Text("Swipe right to change the players teebox")
//                 }
        }
        .onAppear(perform:{
            addGameVM.newTeeBoxForGame = game.defaultTeeBox
        })
    }
}

struct ChangeMatchTeeBoxSheet_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        ChangeMatchTeeBoxSheet(game: game, isPresentedGameTeeBox: .constant(false), neeedsRefresh: .constant(false))
            .environmentObject(CurrentGameFormat())
    }
}

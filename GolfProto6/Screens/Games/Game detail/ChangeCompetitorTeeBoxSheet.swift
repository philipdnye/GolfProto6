//
//  ChangeCompetitorTeeBoxSheet.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct ChangeCompetitorTeeBoxSheet: View {
    @StateObject private var addGameVM = AddGameViewModel()
    @EnvironmentObject var currentGF: CurrentGameFormat
    let competitor: Competitor
    let game: GameViewModel
    @Binding var isPresented: Bool
    @Binding var neeedsRefresh: Bool
    //@State private var newTeeBox: TeeBox = TeeBox()
    var body: some View {
        Form{
            
            
            
            Section{
                Picker("Select teebox", selection: $addGameVM.newTeeBox) {
                    ForEach(game.game.defaultTeeBox?.course?.teeBoxArray ?? [], id: \.self){
                        Text($0.wrappedColour)
                            .tag($0)
                            //.pickerStyle(.segmented)
                    }
                   
                }
                HStack{
                    Spacer()
                    Button("Confirm new teebox"){
                        let manager = CoreDataManager.shared
                       
                        let competitorId = competitor.objectID
                        let currentCompetitor = manager.getCompetitorById(id: competitorId)
                        currentCompetitor?.teeBox = addGameVM.newTeeBox
                        //code here to update course handicap
                        currentCompetitor?.courseHandicap = competitor.CourseHandicap()
                        manager.save()
                        
                        //now run code to recalc all playing handicaps THEN SAVE AGAIN
                        addGameVM.AssignHandicapsAndShots(game: game.game, currentGF: currentGF)
// 
                        isPresented = false
                        neeedsRefresh.toggle()
                    }
                    Spacer()
                }
            }
        header: {
                 Text("Change teebox for \(competitor.FirstName().capitalized) \(competitor.LastName().capitalized)")
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
            addGameVM.newTeeBox = competitor.teeBox ?? TeeBox()
        })
    }
}

struct ChangeCompetitorTeeBoxSheet_Previews: PreviewProvider {
    static var previews: some View {
        let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext)).competitor
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        
        ChangeCompetitorTeeBoxSheet(competitor: competitor, game: game, isPresented: .constant(true), neeedsRefresh: .constant(false))
            .environmentObject(CurrentGameFormat())
    }
}

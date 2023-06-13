//
//  GameListRowItem.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import SwiftUI

struct GameListRowItem: View {
    @StateObject private var gameListVM = GameListViewModel()
    @Binding var needsRefresh: Bool
    let game: GameViewModel
    
    var gameStatus: some View {
        Group{
            switch game.gameStarted{
            case true:
                Text("Game in progess")
            case false:
                Text("Game not started")
            }
        }
    }
    var body: some View {
        VStack(spacing:0){
            HStack{
                Text(game.name.capitalized)
                    .foregroundColor(darkTeal)
                    .font(.headline)
                Spacer()
            }
            HStack{
                Text(game.game.game_format.stringValue())
                    .foregroundColor(darkTeal)
                    .font(.subheadline)
                Spacer()
                HStack(spacing: 0.5){
                    ForEach(game.game.competitorArray) {competitor in
                     
                        Text(competitor.player?.Initials() ?? "")
                            .frame(width:20, height:10)
                            
                            .padding(10)
                            .background(burntOrange)
                            .font(.caption)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    
                }
                .frame(width: 100, alignment: .trailing)
        
            }
            .font(.title3)
            
            VStack(spacing: 0) {
              
                HStack{
                    Text(game.date, format: .dateTime.day().month())
                        .foregroundColor(darkTeal)
                        .font(.subheadline)
                    Spacer()
                  
                        Group{
                            Text("\(game.defaultTeeBox.wrappedColour.capitalized) tees")
                                
                            HStack(spacing: 0){
                                Text(String(game.defaultTeeBox.TotalDistance()))
                               // Text(game.game.defaultTeeBox?.origin?.origin?.distMetric ?? "")
                            }
                            
                            
                            Text("Par: \(game.defaultTeeBox.TotalPar())")
                        }
                        .foregroundColor(darkTeal)
                        .font(.subheadline)
                       
                    
                }
                
                HStack{
                    Text(game.game.defaultTeeBox?.course?.club?.name?.capitalized ?? "")
                        .foregroundColor(burntOrange)
                        .font(.subheadline)
                      
                        //.padding([.top],6)
                    Spacer()
                    if game.gameFinished == false {
                        gameStatus
                            .foregroundColor(burntOrange)
                            .font(.subheadline)
                          //  .padding([.top],6)
                    } else {
                        Text("Game finished")
                            .foregroundColor(burntOrange)
                            .font(.subheadline)
                           // .padding([.top],6)
                        
                    }
                }
            }
            
            
            
            
            
            
            
//            HStack{
//                Text(game.game.sc_format.stringValue())
//                Text(game.game.hcap_format.stringValue())
//
//                Text(game.defaultTeeBox.wrappedColour)
//                Text(game.defaultTeeBox.origin?.name ?? "")
//                Text(game.defaultTeeBox.origin?.origin?.wrappedName ?? "")
//            }
        }
    }
}

struct GameListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        GameListRowItem(needsRefresh: .constant(false), game: game)
    }
}

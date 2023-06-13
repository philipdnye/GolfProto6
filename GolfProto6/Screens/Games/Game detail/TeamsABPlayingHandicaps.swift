//
//  TeamsABPlayingHandicaps.swift
//  GolfProto04
//
//  Created by Philip Nye on 23/04/2023.
//

import SwiftUI

struct TeamsABPlayingHandicaps: View {
    @EnvironmentObject var currentGF: CurrentGameFormat
    @Binding var needsRefesh: Bool
    let game: GameViewModel
    var body: some View {
        
        
        switch currentGF.noOfPlayersNeeded{
            
        case 2:
            
            HStack(spacing: 0){
                Text("Team playing handicap ")
                    .font(.subheadline)
                    .foregroundColor(darkTeal)
                Text(String(format: "%.2f",game.game.TotalPlayingHandicapA()))
                    .font(.title2)
                    .foregroundColor(burntOrange)
                    .fontWeight(.semibold)
                
                Text(" (\(String(format: "%.0f",round(game.game.TotalPlayingHandicapA()))))")
                    .font(.title2)
                    .foregroundColor(burntOrange)
                    .fontWeight(.semibold)
                
                Text(needsRefesh.description)
                    .opacity(0)
                    .frame(width:0, height: 0)
            }
            .font(.title2)
            .foregroundColor(burntOrange)
            .fontWeight(.semibold)
            
            
        default:
            HStack{
                Text("Team playing handicaps  A: \(String(format: "%.2f",game.game.TotalPlayingHandicapA()))  B: \(String(format: "%.2f",game.game.TotalPlayingHandicapB()))")
                Text(needsRefesh.description)
                    .opacity(0)
                    .frame(width:0, height: 0)
            }
            .font(.subheadline)
            .foregroundColor(darkTeal)
            
            
            
        }
        
    }
}

struct TeamsABPlayingHandicaps_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        TeamsABPlayingHandicaps(needsRefesh: .constant(false),game: game)
            .environmentObject(CurrentGameFormat())
    }
}

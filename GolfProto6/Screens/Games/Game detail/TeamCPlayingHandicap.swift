//
//  TeamCPlayingHandicap.swift
//  GolfProto04
//
//  Created by Philip Nye on 23/04/2023.
//

import SwiftUI

struct TeamCPlayingHandicap: View {
    @Binding var needsRefresh: Bool
    let game: GameViewModel
    var body: some View {
        if !game.game.teamShotsArray.isEmpty {
            HStack{
                Text("Team C playing handicap: \(game.game.teamShotsArray[2].playingHandicap.formatted()) +")
                Text(String(format: "%.2f",game.game.teamShotsArray[2].diffTeesXShots))
                Text(String(format: "%.2f", game.game.TotalPlayingHandicapC()))
                    .foregroundColor(burntOrange)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(needsRefresh.description)
                    .opacity(0)
                    .frame(width:0, height: 0)
            }
            .font(.subheadline)
            .foregroundColor(darkTeal)
        }
    }
}

struct TeamCPlayingHandicap_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        TeamCPlayingHandicap(needsRefresh: .constant(false), game: game)
    }
}

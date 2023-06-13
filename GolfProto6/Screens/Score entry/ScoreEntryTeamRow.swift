//
//  ScoreEntryTeamRow.swift
//  GolfProto05
//
//  Created by Philip Nye on 10/05/2023.
//

import SwiftUI

struct ScoreEntryTeamRow: View {
    
    var competitorIndex: Int
    

    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    
    var body: some View {
        HStack(spacing:0){
            HStack(spacing: 5){
                
                Text(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].FirstName())
                Text(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].LastName().prefix(1).capitalized)
               
            }
            .font(.title)
            .font(.footnote.weight(.semibold))
            .foregroundColor(darkTeal)
            .padding([.leading],10)
            
            Spacer()
            
        }
    }
}

struct ScoreEntryTeamRow_Previews: PreviewProvider {
    static var previews: some View {
        ScoreEntryTeamRow(competitorIndex: 0)
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
    }
}

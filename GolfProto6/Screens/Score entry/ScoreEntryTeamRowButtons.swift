//
//  ScoreEntryTeamRowButtons.swift
//  GolfProto05
//
//  Created by Philip Nye on 10/05/2023.
//

import SwiftUI

struct ScoreEntryTeamRowButtons: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    @Binding var needsRefresh: Bool
    var teamIndex: Int
    var body: some View {
        HStack(spacing:25){
            Button(action: {
          
                scoreEntryVM.teamsScores[scoreEntryVM.holeIndex][teamIndex] -= 1
                scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][teamIndex] = true
                needsRefresh.toggle()
                switch currentGF.assignShotsRecd {
                    
                case .TeamsAB:
                    scoreEntryVM.saveCompetitorsScoreTeam()
                    needsRefresh.toggle()
                case .TeamC:
                    scoreEntryVM.saveCompetitorScoreTeamC()
                    needsRefresh.toggle()
                default:
                    scoreEntryVM.saveCompetitorsScoreTeam()
                    needsRefresh.toggle()
                    
                }
                
                
            }) {
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(gold)
            }
           
            
//
            switch scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][teamIndex] {// changes the opacity of the font depending on whther the score has been committed
            case false:
                TeamRowScoreBox(teamIndex: teamIndex, opacity: 0.5, needsRefresh: $needsRefresh)
                
//
            case true:
                TeamRowScoreBox(teamIndex: teamIndex, opacity: 1.0, needsRefresh: $needsRefresh)
            }
            
            Button(action: {
               
                scoreEntryVM.teamsScores[scoreEntryVM.holeIndex][teamIndex] += 1
                scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][teamIndex] = true
                needsRefresh.toggle()
                
                switch currentGF.assignShotsRecd {
                    
                case .TeamsAB:
                    scoreEntryVM.saveCompetitorsScoreTeam()
                    needsRefresh.toggle()
                case .TeamC:
                    scoreEntryVM.saveCompetitorScoreTeamC()
                    needsRefresh.toggle()
                default:
                    scoreEntryVM.saveCompetitorsScoreTeam()
                    needsRefresh.toggle()
                    
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(gold)
            }
        }
    }
}

struct ScoreEntryTeamRowButtons_Previews: PreviewProvider {
    static var previews: some View {
        ScoreEntryTeamRowButtons(needsRefresh: .constant(false), teamIndex: 0)
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
    }
}

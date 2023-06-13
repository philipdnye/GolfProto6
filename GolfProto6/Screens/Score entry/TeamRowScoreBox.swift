//
//  TeamRowScoreBox.swift
//  GolfProto05
//
//  Created by Philip Nye on 10/05/2023.
//

import SwiftUI

struct TeamRowScoreBox: View {
    var teamIndex: Int
    var opacity: Double = 0.0
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    @Binding var needsRefresh: Bool
    
    var body: some View {
        ZStack{
            Text(scoreEntryVM.teamsScores[scoreEntryVM.holeIndex][teamIndex].formatted())
            
                .frame(width: 32, height: 32)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(darkTeal, lineWidth: 2)
                )
            
                .font(.title)
                .font(.footnote.weight(.bold))
                .foregroundColor(.brown)
                .opacity(opacity)
                .onTapGesture(count: 2, perform:{
                    scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][teamIndex].toggle()
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
                })
            
            // need a switch here for match or strokeplay
            
            switch currentGF.assignShotsRecd {
                
            case .TeamsAB:
                
                switch currentGF.playFormat {
                case .matchplay:
                    if scoreEntryVM.currentGame.game.teamScoresArray.filter({$0.team == teamIndex}).sorted(by: {$0.hole < $1.hole})[scoreEntryVM.holeIndex].shotsRecdHoleMatch != 0 {
                        
                        Text(scoreEntryVM.currentGame.game.teamScoresArray.filter({$0.team == teamIndex}).sorted(by: {$0.hole < $1.hole})[scoreEntryVM.holeIndex].shotsRecdHoleMatch.formatted()) //sorted??
                            .offset(x: 22, y: 18)
                            .foregroundColor(burntOrange)
                            .fontWeight(.semibold)
                    }
                    
                case .strokeplay:
                    if scoreEntryVM.currentGame.game.teamScoresArray.filter({$0.team == teamIndex}).sorted(by: {$0.hole < $1.hole})[scoreEntryVM.holeIndex].shotsRecdHoleStroke != 0 {
                        Text(scoreEntryVM.currentGame.game.teamScoresArray.filter({$0.team == teamIndex}).sorted(by: {$0.hole < $1.hole})[scoreEntryVM.holeIndex].shotsRecdHoleStroke.formatted())
                            .offset(x: 22, y: 18)
                            .foregroundColor(burntOrange)
                            .fontWeight(.semibold)
                    }
                }
                
            case .TeamC:
                EmptyView()
            default:
               EmptyView()
                
                
                
            }
            
            
        }
    }
}

struct TeamRowScoreBox_Previews: PreviewProvider {
    static var previews: some View {
        TeamRowScoreBox(teamIndex: 0, opacity: 1, needsRefresh: .constant(false))
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
    }
}

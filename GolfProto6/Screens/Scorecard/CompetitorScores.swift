//
//  CompetitorScores.swift
//  GolfProto05
//
//  Created by Philip Nye on 12/05/2023.
//

import SwiftUI

struct CompetitorScores: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    var holeIndex: Int = 0
    var teamAssignment: Assignment = .Indiv
    var totalType: TotalType = .overall
    var teamScoreArray: [TeamScore] = []
    var subTotalGross: Int = 0
    var subTotalPoints: Int = 0

    var body: some View {
        
        switch currentGF.assignShotsRecd {
        case .Indiv:
            switch totalType {
            case .hole:
                
                ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){competitor in
                    
                    ZStack{
                        if competitor.competitorScoresArray[holeIndex].scoreCommitted {
                            Text(competitor.competitorScoresArray[holeIndex].grossScore.formatted())
                                .foregroundColor(.blue)
                            
                            if competitor.competitorScoresArray[holeIndex].StablefordPointsNet() != 0 {
                                Text(competitor.competitorScoresArray[holeIndex].StablefordPointsNet().formatted())
                                    .foregroundColor(burntOrange)
                                    .font(.caption)
                                    .offset(x: 10, y: 5)
                            }
                        }
                    }//ZStack
                    
                }//Foreach
            case .frontNine:
                ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){ competitor in
                    
                    if competitor.competitorScoresArray.TotalGrossScore_front9() != 0 {
                        ZStack{
                            Text(competitor.competitorScoresArray.TotalGrossScore_front9().formatted())
                                .foregroundColor(.blue)
                            Text(competitor.competitorScoresArray.TotalStablefordPoints_front9().formatted())
                                .foregroundColor(burntOrange)
                                .font(.caption)
                                .offset(x: 15, y: 10)
                            
                        }
                    }
                    
                }
            case .backNine:
                ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){ competitor in
                    
                    if competitor.competitorScoresArray.TotalGrossScore_back9() != 0 {
                        ZStack{
                            Text(competitor.competitorScoresArray.TotalGrossScore_back9().formatted())
                                .foregroundColor(.blue)
                            Text(competitor.competitorScoresArray.TotalStablefordPoints_back9().formatted())
                                .foregroundColor(burntOrange)
                                .font(.caption)
                                .offset(x: 15, y: 10)
                            
                        }
                    }
                    
                }
            case .overall:
                ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){ competitor in
                    
                    if competitor.competitorScoresArray.TotalGrossScore() != 0 {
                        
                        
                        ZStack{
                            Text(competitor.competitorScoresArray.TotalGrossScore().formatted())
                                .foregroundColor(.blue)
                            Text(competitor.competitorScoresArray.TotalStablefordPoints().formatted())
                                .foregroundColor(burntOrange)
                                .font(.caption)
                                .offset(x: 15, y: 10)
                            
                        }
                    }
                    
                }
            }
        case .TeamsAB:
            switch totalType {
            case .hole:
                
                ZStack{
                    if teamScoreArray[holeIndex].scoreCommitted {
                        
                        Text(teamScoreArray[holeIndex].grossScore.formatted())
                            .foregroundColor(.blue)
                       
                        if teamScoreArray[holeIndex].StablefordPointsNet() != 0 {
                            Text(teamScoreArray[holeIndex].StablefordPointsNet().formatted())
                                .foregroundColor(burntOrange)
                                .font(.caption)
                                .offset(x: 10, y: 5)
                        }
                        
                        ZStack{
                            if teamScoreArray[holeIndex].grossScore < 10 {
                                Text("\(teamScoreArray[holeIndex].grossScore.formatted())/\(teamScoreArray[holeIndex].NetScoreMatch().formatted())")
                                    .frame(width: 30)
                                    .background(.yellow)
                                    .offset(x:70, y: 0)
                                    .foregroundColor(darkTeal)
                                    .font(.callout)
                            } else {
                                Text("\(teamScoreArray[holeIndex].grossScore.formatted())/\(teamScoreArray[holeIndex].NetScoreMatch().formatted())")
                                    .frame(width: 30)
                                    .background(.yellow)
                                    .offset(x:70, y: 0)
                                    .foregroundColor(darkTeal)
                                    .font(.caption)
                            }
                            if teamScoreArray[holeIndex].shotsRecdHoleMatch != 0 {
                                Text(teamScoreArray[holeIndex].shotsRecdHoleMatch.formatted())
                                    .offset(x:84, y:-8)
                                    .foregroundColor(burntOrange)
                                    .font(.caption2)
                            }
                        }
                        
                    }
                }
           default: // this will trigger for any subtotal
                ZStack{
                    if subTotalGross != 0 {
                        
                        Text(subTotalGross.formatted())
                            .foregroundColor(.blue)
                        
                        if subTotalPoints != 0 {
                            Text(subTotalPoints.formatted())
                                .foregroundColor(burntOrange)
                                .font(.caption)
                                .offset(x: 13, y: 5)
                        }
                    }
                }
                
            }
        case .TeamC:
            switch totalType {
            case .hole:
                
                ZStack{
                    if teamScoreArray[holeIndex].scoreCommitted {
                        
                        Text(teamScoreArray[holeIndex].grossScore.formatted())
                            .foregroundColor(.blue)
                        
                        if teamScoreArray[holeIndex].StablefordPointsNet() != 0 {
                            Text(teamScoreArray[holeIndex].StablefordPointsNet().formatted())
                                .foregroundColor(burntOrange)
                                .font(.caption)
                                .offset(x: 10, y: 5)
                        }
                    }
                }
           default: // this will trigger for any subtotal
                ZStack{
                    if subTotalGross != 0 {
                        
                        Text(subTotalGross.formatted())
                            .foregroundColor(.blue)
                        
                        if subTotalPoints != 0 {
                            Text(subTotalPoints.formatted())
                                .foregroundColor(burntOrange)
                                .font(.caption)
                                .offset(x: 13, y: 5)
                        }
                    }
                }
                
            }
            
            
            
        }
    }
}

struct CompetitorScores_Previews: PreviewProvider {
    static var previews: some View {
        CompetitorScores(holeIndex: 0, teamAssignment: .Indiv, totalType: .overall, teamScoreArray: [])
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
    }
}

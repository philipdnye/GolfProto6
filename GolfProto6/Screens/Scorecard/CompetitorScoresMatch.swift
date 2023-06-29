//
//  CompetitorScoresMatch.swift
//  GolfProto6
//
//  Created by Philip Nye on 27/06/2023.
//

import SwiftUI

struct CompetitorScoresMatch: View {
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
                            if competitor.competitorScoresArray[holeIndex].grossScore < 10 {
                                Text(competitor.competitorScoresArray[holeIndex].grossScore.formatted())
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .zIndex(1)
                            } else {
                                Text(competitor.competitorScoresArray[holeIndex].grossScore.formatted())
                                    .font(.callout)
                                    .foregroundColor(.blue)
                                    .zIndex(1)
                                
                                
                            }
   
                                Text(competitor.competitorScoresArray[holeIndex].NetScoreMatch().formatted())
                                    .foregroundColor(burntOrange)
                                    .font(.headline)
                                    .offset(x: 11, y: 5)
                                    .zIndex(1)
                                

                            
                            ShotsRecdDots(shotsReceived: Int(competitor.competitorScoresArray[holeIndex].shotsRecdHoleMatch))
                                .offset(x: 2, y: 13.5)
                                .zIndex(1)
                            // determine symbol to encase the score
                            
                            //ScoreSymbol(grossScoreToPar: competitor.competitorScoresArray[holeIndex].GrossScoreToPar())
                                .zIndex(0)
                           
                            if competitor.competitorScoresArray[holeIndex].NetScoreMatch() == scoreEntryVM.currentGame.game.LowScoreByHole4BBB(holeIndex: holeIndex){
                                ZStack{
                                    
                                    
                                        
                                       
                                    
                                        Image(systemName: "square.fill")
                                            .font(.system(size: 36, weight: .ultraLight))
                                            .foregroundColor(veryLightTeal)
                                            .offset(x: 5, y: 2)
                                            .zIndex(0)
                                   
                                    
                                }
                            }
                           
                            
                        }
                    }//ZStack
                   
                }//Foreach
            case .frontNine:
                ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){ competitor in
                    
                    if competitor.competitorScoresArray.TotalGrossScore_front9() != 0 {
                        ZStack{
                            Text(competitor.competitorScoresArray.TotalGrossScore_front9().formatted())
                                .font(.title3)
                                .foregroundColor(.blue)
//                            Text(competitor.competitorScoresArray.TotalStablefordPoints_front9().formatted())
//                                .font(.title3)
//                                .foregroundColor(burntOrange)
//
//                                .offset(x: 21, y: 16)
                            
                        }
                    }
                    
                }
            case .backNine:
                ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){ competitor in
                    
                    if competitor.competitorScoresArray.TotalGrossScore_back9() != 0 {
                        ZStack{
                            Text(competitor.competitorScoresArray.TotalGrossScore_back9().formatted())
                                .font(.title3)
                                .foregroundColor(.blue)
//                            Text(competitor.competitorScoresArray.TotalStablefordPoints_back9().formatted())
//                                .font(.title3)
//                                .foregroundColor(burntOrange)
//
//                                .offset(x: 21, y: 16)
                            
                        }
                    }
                    
                }
            case .overall:
                ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){ competitor in
                    
                    if competitor.competitorScoresArray.TotalGrossScore() != 0 {
                        
                        
                        ZStack{
                            Text(competitor.competitorScoresArray.TotalGrossScore().formatted())
                                .font(.title3)
                                .foregroundColor(.blue)
//                            Text(competitor.competitorScoresArray.TotalStablefordPoints().formatted())
//                                .font(.title3)
//                                .foregroundColor(burntOrange)
//                               
//                                .offset(x: 21, y: 16)
//                            
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

struct CompetitorScoresMatch_Previews: PreviewProvider {
    static var previews: some View {
        CompetitorScoresMatch()
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
    }
}

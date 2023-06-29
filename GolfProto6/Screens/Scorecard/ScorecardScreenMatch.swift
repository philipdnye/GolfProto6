//
//  ScorecardScreenMatch.swift
//  GolfProto05
//
//  Created by Philip Nye on 14/05/2023.
//

import SwiftUI

struct ScorecardScreenMatch: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    
    var body: some View {
        GeometryReader{geo in
       
            List{
                HStack(spacing: 0){
                    Group{
                        
                        ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self) {
//                            Spacer()
//                                .frame(width: geo.size.width * 0.0001)
                            Text($0.player?.Initials() ?? "")
                        }
                    }
                    .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                }
                .offset(x: geo.size.width * 0.35)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .listRowBackground(darkTeal)
                
                let front9Holes = Array(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray ?? []).prefix(9)
               
                ForEach(0..<front9Holes.count, id: \.self) {holeIndex in
                    HStack(spacing:0){
                       
                        Text(Int(front9Holes[holeIndex].number).formatted())
                            .font(.headline)
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.05)
                            .foregroundColor(darkTeal)
//                            .background(.yellow)
                            
                        Text(Int(front9Holes[holeIndex].distance).formatted())
                            .font(.headline)
                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.05)
                            .foregroundColor(darkTeal)
//                            .background(.yellow)
                        
                        Text(Int(front9Holes[holeIndex].par).formatted())
                            .font(.headline)
                            .frame(width: geo.size.width * 0.04, height: geo.size.height * 0.05)
                            .foregroundColor(darkTeal)
//                            .background(.yellow)
                       
                        Text(Int(front9Holes[holeIndex].strokeIndex).formatted())
                            .font(.headline)
                            .frame(width: geo.size.width * 0.06, height: geo.size.height * 0.05)
                            .foregroundColor(burntOrange)
//                            .background(.yellow)
                           // .background(.blue)
                 
                        switch currentGF.assignShotsRecd {
                        case .Indiv:
                            HStack(spacing:0){
                                CompetitorScoresMatch(holeIndex: holeIndex, teamAssignment: .Indiv, totalType: .hole)
                                
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                                //.background(.yellow)
                                .offset(x: geo.size.width * 0.026)
                              
                                // shows the lowest net score by hole
//                                Text(scoreEntryVM.currentGame.game.LowScoreByHole4BBB(holeIndex: holeIndex).formatted())
//                                    .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
//                                    .background(.yellow)
//                                    .offset(x: geo.size.width * 0.026)
                            }
                        case .TeamsAB:
                            
                            HStack(spacing:0){
//
                                    CompetitorScores(holeIndex: holeIndex, teamAssignment: .TeamsAB, totalType: .hole, teamScoreArray: scoreEntryVM.currentGame.game.teamAScoresArray)
                                        .frame(width: geo.size.width * 0.07, height: geo.size.height * 0.05, alignment: .center)
                                        .background(.red)
                                        .offset(x: geo.size.width * 0.015)
                                       
                                    CompetitorScores(holeIndex: holeIndex, teamAssignment: .TeamsAB, totalType: .hole, teamScoreArray: scoreEntryVM.currentGame.game.teamBScoresArray)
                                        .frame(width: geo.size.width * 0.07, height: geo.size.height * 0.05, alignment: .center)
                                        .background(.red)
                                        .offset(x: geo.size.width * 0.026)
                                if scoreEntryVM.currentGame.game.teamAScoresArray[holeIndex].scoreCommitted && scoreEntryVM.currentGame.game.teamBScoresArray[holeIndex].scoreCommitted {
                                    HStack(spacing: 0){
                                        
               
                                    }
                                }
                                
                            }
                        case .TeamC:
                            HStack(spacing:geo.size.width * 0.048){
                                Spacer()
                                    .frame(width: geo.size.width * 0.011)
                                Group{
                                    CompetitorScores(holeIndex: holeIndex, teamAssignment: .TeamC, totalType: .hole, teamScoreArray: scoreEntryVM.currentGame.game.teamCScoresArray)
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                                .offset(x: geo.size.width * 0.026)
                            }
                        }//switch
                        //string version of score by hole
                        
//                        Text(scoreEntryVM.currentGame.game.CalcCurrentMatchScore(currentGF: currentGF, byHole: true, holeIndex: holeIndex+1).0.formatted())
//                            .offset(x: 20, y: 0)
                        Divider()
                                        .frame(width: 1)

                                        .overlay(.gray)
                                        .offset(x: 17, y:0)

                        HStack(spacing:0){
                            Text(scoreEntryVM.currentGame.game.CurrentMatchScoreByHoleString(currentMatchScore: scoreEntryVM.currentGame.game.CalcCurrentMatchScore(currentGF: currentGF, byHole: true, holeIndex: holeIndex+1).0, holesPlayed: holeIndex, currentGF: currentGF).0)
                                
                           
                                
                                .offset(x: 20, y: 0)
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                            Text(scoreEntryVM.currentGame.game.CurrentMatchScoreByHoleString(currentMatchScore: scoreEntryVM.currentGame.game.CalcCurrentMatchScore(currentGF: currentGF, byHole: true, holeIndex: holeIndex+1).0, holesPlayed: holeIndex, currentGF: currentGF).1)
                                .offset(x: 45, y: 0)
                            Text(scoreEntryVM.currentGame.game.CurrentMatchScoreByHoleString(currentMatchScore: scoreEntryVM.currentGame.game.CalcCurrentMatchScore(currentGF: currentGF, byHole: true, holeIndex: holeIndex+1).0, holesPlayed: holeIndex, currentGF: currentGF).2)
                              
                                .offset(x: 70, y: 0)
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                        }
                    }
            }//foreach
               
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalDistance() ?? 0))
                            .font(.title3)
                            .frame(width:geo.size.width * 0.18)
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalPar() ?? 0))
                            .font(.title3)
                            .frame(width:geo.size.width * 0.075)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    // players front 9 totals
                
                    switch currentGF.assignShotsRecd{
                    case .Indiv:
                        HStack(spacing: 0){
                            Group{
                               
                                CompetitorScoresMatch(teamAssignment: .Indiv, totalType: .frontNine)
                            }//Group
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                        }//HStack
                        
                        .offset(x: geo.size.width * 0.095)
                        
                        .fontWeight(.semibold)
                    case .TeamsAB:
                        
                        HStack(spacing: geo.size.width * 0.048) {
                            Spacer()
                                .frame(width: geo.size.width * 0.011)
                            Group{
                                CompetitorScores(teamAssignment: .TeamsAB, totalType: .frontNine, subTotalGross: Int(scoreEntryVM.currentGame.game.teamAScoresArray.TotalGrossScore_front9()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamAScoresArray.TotalStablefordPoints_front9()))

                                CompetitorScores(teamAssignment: .TeamsAB, totalType: .frontNine, subTotalGross: Int(scoreEntryVM.currentGame.game.teamBScoresArray.TotalGrossScore_front9()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamBScoresArray.TotalStablefordPoints_front9()))
                         
                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                            
                        }
                        .offset(x: geo.size.width * 0.12)
                        
                        .fontWeight(.semibold)
                        
                       
                    case .TeamC:
                        HStack(spacing: geo.size.width * 0.048) {
                            Spacer()
                                .frame(width: geo.size.width * 0.011)
                            Group{
                                CompetitorScores(teamAssignment: .TeamC, totalType: .frontNine, subTotalGross: Int(scoreEntryVM.currentGame.game.teamCScoresArray.TotalGrossScore_front9()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamCScoresArray.TotalStablefordPoints_front9()))

                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                            
                        }
                        .offset(x: geo.size.width * 0.12)
                        
                        .fontWeight(.semibold)
                        
                    }//switch
                    
                }//totals HStack
                .listRowBackground(veryLightTeal)
                
                let back9Holes = Array(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray ?? []).suffix(9)
                
                ForEach(0..<back9Holes.count, id: \.self) {holeIndex in
                    HStack(spacing:1){
                       
                        Text(Int(back9Holes[holeIndex + 9].number).formatted())
                            .font(.title3)
                            .frame(width: geo.size.width * 0.06, height: geo.size.height * 0.05)
                            .foregroundColor(darkTeal)
                       
                        Text(Int(back9Holes[holeIndex + 9].distance).formatted())
                            .font(.title3)
                            .frame(width: geo.size.width * 0.12, height: geo.size.height * 0.05)
                            .foregroundColor(darkTeal)
                       
                        Text(Int(back9Holes[holeIndex + 9].par).formatted())
                            .font(.title3)
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.05)
                            .foregroundColor(darkTeal)
                        
                        Text(Int(back9Holes[holeIndex + 9].strokeIndex).formatted())
                            .font(.title3)
                            .frame(width: geo.size.width * 0.07, height: geo.size.height * 0.05)
                            .foregroundColor(burntOrange)
                        
                        switch currentGF.assignShotsRecd {
                            
                        case .Indiv:
                        
                            HStack(spacing:0){
                                Group{
                                    CompetitorScoresMatch(holeIndex: holeIndex+9, teamAssignment: .Indiv, totalType: .hole)
//
                                }
                                .foregroundColor(.blue)
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                                .offset(x: geo.size.width * 0.026)
                            }
                            
                        case .TeamsAB:
                           
                            HStack(spacing:geo.size.width * 0.048){
                                Spacer()
                                    .frame(width: geo.size.width * 0.011)
                                Group{
                                    CompetitorScores(holeIndex: holeIndex+9, teamAssignment: .TeamsAB, totalType: .hole, teamScoreArray: scoreEntryVM.currentGame.game.teamAScoresArray)
                                    CompetitorScores(holeIndex: holeIndex+9, teamAssignment: .TeamsAB, totalType: .hole, teamScoreArray: scoreEntryVM.currentGame.game.teamBScoresArray)
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                                .offset(x: geo.size.width * 0.026)
                            }
                        
                        case .TeamC:
                            HStack(spacing:geo.size.width * 0.048){
                                Spacer()
                                    .frame(width: geo.size.width * 0.011)
                                Group{
                                    CompetitorScores(holeIndex: holeIndex+9, teamAssignment: .TeamC, totalType: .hole, teamScoreArray: scoreEntryVM.currentGame.game.teamCScoresArray)
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                                .offset(x: geo.size.width * 0.026)
                                
                            }
                        }
                    }
                }
                
                // hole back 9 totals
                    HStack(spacing:0){
      
                        HStack(spacing:0){
                            Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_back9.TotalDistance() ?? 0))
                                .font(.title3)
                                .frame(width:geo.size.width * 0.18)
                            Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_back9.TotalPar() ?? 0))
                                .font(.title3)
                                .frame(width:geo.size.width * 0.075)
                        }
                        .foregroundColor(darkTeal)
                        .fontWeight(.semibold)
                    
                        // players back 9 totals
                        
                        switch currentGF.assignShotsRecd {
                            
                        case .Indiv:
                            HStack(spacing: 0){
                                Group{

                                    CompetitorScoresMatch(teamAssignment: .Indiv, totalType: .backNine)
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                            }
                            .offset(x: geo.size.width * 0.095)
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                            
                        case .TeamsAB:
                            HStack(spacing: geo.size.width * 0.048) {
                                Spacer()
                                    .frame(width: geo.size.width * 0.011)
                                Group{
                                    
                                        CompetitorScores(teamAssignment: .TeamsAB, totalType: .backNine, subTotalGross: Int(scoreEntryVM.currentGame.game.teamAScoresArray.TotalGrossScore_back9()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamAScoresArray.TotalStablefordPoints_back9()))

                                        CompetitorScores(teamAssignment: .TeamsAB, totalType: .backNine, subTotalGross: Int(scoreEntryVM.currentGame.game.teamBScoresArray.TotalGrossScore_back9()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamBScoresArray.TotalStablefordPoints_back9()))
                                  
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                                
                            }
                            .offset(x: geo.size.width * 0.12)
                            
                            .fontWeight(.semibold)
                        case .TeamC:
                            HStack(spacing: geo.size.width * 0.048) {
                                Spacer()
                                    .frame(width: geo.size.width * 0.011)
                                Group{
                                    CompetitorScores(teamAssignment: .TeamC, totalType: .backNine, subTotalGross: Int(scoreEntryVM.currentGame.game.teamCScoresArray.TotalGrossScore_back9()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamCScoresArray.TotalStablefordPoints_back9()))

                                   
                             
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                                
                            }
                            .offset(x: geo.size.width * 0.12)
                            
                            .fontWeight(.semibold)
                            
                            
                        }
                    }//back 9 HStack
                    .listRowBackground(veryLightTeal)
                // players front 9 totals
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalDistance() ?? 0))
                            .font(.title3)
                            .frame(width:geo.size.width * 0.18)
                            
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalPar() ?? 0))
                            .font(.title3)
                            .frame(width:geo.size.width * 0.075)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                  
                    // players fromt 9 totals
                    switch currentGF.assignShotsRecd {
                    case .Indiv:
                        HStack(spacing: 0){
                            Group{
                               
                                CompetitorScoresMatch(teamAssignment: .Indiv, totalType: .frontNine)
                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                        }
                        .offset(x: geo.size.width * 0.095)
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                        
                    case .TeamsAB:
                        HStack(spacing: geo.size.width * 0.048) {
                            Spacer()
                                .frame(width: geo.size.width * 0.011)
                            Group{
                                CompetitorScores(teamAssignment: .TeamsAB, totalType: .frontNine, subTotalGross: Int(scoreEntryVM.currentGame.game.teamAScoresArray.TotalGrossScore_front9()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamAScoresArray.TotalStablefordPoints_front9()))

                                CompetitorScores(teamAssignment: .TeamsAB, totalType: .frontNine, subTotalGross: Int(scoreEntryVM.currentGame.game.teamBScoresArray.TotalGrossScore_front9()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamBScoresArray.TotalStablefordPoints_front9()))
                  
                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                            
                        }
                        .offset(x: geo.size.width * 0.12)
                        
                        .fontWeight(.semibold)
                    case .TeamC:
                        HStack(spacing: geo.size.width * 0.048) {
                            Spacer()
                                .frame(width: geo.size.width * 0.011)
                            Group{
                                CompetitorScores(teamAssignment: .TeamC, totalType: .frontNine, subTotalGross: Int(scoreEntryVM.currentGame.game.teamCScoresArray.TotalGrossScore_front9()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamCScoresArray.TotalStablefordPoints_front9()))

                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                            
                        }
                        .offset(x: geo.size.width * 0.12)
                        
                        .fontWeight(.semibold)
                        
                    }
                }//front 9 HStack
                .listRowBackground(veryLightTeal)
                // players  totals
                HStack(spacing:0){
                    //hole summary overall
                    HStack(spacing:0){
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.TotalDistance() ?? 0))
                            .font(.title3)
                            .frame(width:geo.size.width * 0.18)
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.TotalPar() ?? 0))
                            .font(.title3)
                            .frame(width:geo.size.width * 0.075)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    
                    
                    
                    // players overall totals
                    switch currentGF.assignShotsRecd {
                    case .Indiv:
                        HStack(spacing: 0){
                            Group{
                               // CompetitorScores_IndivTotal(competitors: scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF))
                                CompetitorScoresMatch(teamAssignment: .Indiv, totalType: .overall)
                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                        }
                        .offset(x: geo.size.width * 0.095)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                    
                    case .TeamsAB:
                        HStack(spacing: geo.size.width * 0.048) {
                            Spacer()
                                .frame(width: geo.size.width * 0.011)
                            Group{
                                CompetitorScores(teamAssignment: .TeamsAB, totalType: .overall, subTotalGross: Int(scoreEntryVM.currentGame.game.teamAScoresArray.TotalGrossScore()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamAScoresArray.TotalStablefordPoints()))

                                CompetitorScores(teamAssignment: .TeamsAB, totalType: .overall, subTotalGross: Int(scoreEntryVM.currentGame.game.teamBScoresArray.TotalGrossScore()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamBScoresArray.TotalStablefordPoints()))

                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                            
                        }
                        .offset(x: geo.size.width * 0.12)
                        
                        .fontWeight(.bold)
                    case .TeamC:
                        HStack(spacing: geo.size.width * 0.048) {
                            Spacer()
                                .frame(width: geo.size.width * 0.011)
                            Group{
                                CompetitorScores(teamAssignment: .TeamC, totalType: .overall, subTotalGross: Int(scoreEntryVM.currentGame.game.teamCScoresArray.TotalGrossScore()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamCScoresArray.TotalStablefordPoints()))

                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                            
                        }
                        .offset(x: geo.size.width * 0.12)
                        
                        .fontWeight(.bold)
                        
                    }
                } //overall total HStack
                .listRowBackground(totalsTeal)
                
                
                HStack(spacing: 0){
                    Group{
                        ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self) {
                            Text($0.player?.Initials() ?? "")
                        }
                           
                    }
                    .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                }
                .offset(x: geo.size.width * 0.35)
                .foregroundColor(.white)
                .fontWeight(.semibold)
               
                
                .listRowBackground(darkTeal)
                
            }
           
            
            
        }
    }
    }


struct ScorecardScreenMatch_Previews: PreviewProvider {
    static var previews: some View {
        ScorecardScreenMatch()
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
    }
}

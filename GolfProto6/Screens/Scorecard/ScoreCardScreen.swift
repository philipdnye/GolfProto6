//
//  ScoreCardScreen.swift
//  GolfProto04
//
//  Created by Philip Nye on 27/04/2023.
//

import SwiftUI

enum TotalType: Int, CaseIterable {
    case hole = 0
    case frontNine = 1
    case backNine = 2
    case overall = 3
    
    func stringValue() -> String{
        switch(self){
        case .hole:
            return "individual hole"
        case .frontNine:
            return "front 9"
        case .backNine:
            return "back 9"
        case .overall:
            return "overall"
            
        }
    }
}
    



struct ScorecardScreen: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    
    var body: some View {
      
        GeometryReader{geo in
        
            List{
                HStack(spacing: 0){
                    Group{
                        ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self) {
                            Text($0.player?.Initials() ?? "")
                        }
                    }
                    .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                }
                .offset(x: geo.size.width * 0.31)
                .foregroundColor(darkTeal)
                .fontWeight(.semibold)
                
                let front9Holes = Array(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray ?? []).prefix(9)
                
                
                
                ForEach(0..<front9Holes.count, id: \.self) {holeIndex in
                    HStack(spacing:0){
                       
                        Text(Int(front9Holes[holeIndex].number).formatted())
                            .frame(width: geo.size.width * 0.06, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        
                        Text(Int(front9Holes[holeIndex].distance).formatted())
                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        
                        Text(Int(front9Holes[holeIndex].par).formatted())
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                       
                        Text(Int(front9Holes[holeIndex].strokeIndex).formatted())
                            .frame(width: geo.size.width * 0.07, height: geo.size.height * 0.03)
                            .foregroundColor(burntOrange)
                            .background(.blue)
                 
                        switch currentGF.assignShotsRecd {
                        case .Indiv:
                            HStack(spacing:0){
                                CompetitorScores(holeIndex: holeIndex, teamAssignment: .Indiv, totalType: .hole)
                                
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                .offset(x: geo.size.width * 0.026)
                            }
                        case .TeamsAB:
                            
                            HStack(spacing:0){
//                                Spacer()
//                                    .frame(width: geo.size.width * 0.011)
                                
                                    
                                    CompetitorScores(holeIndex: holeIndex, teamAssignment: .TeamsAB, totalType: .hole, teamScoreArray: scoreEntryVM.currentGame.game.teamAScoresArray)
                                        .frame(width: geo.size.width * 0.07, height: geo.size.height * 0.03, alignment: .center)
                                        .background(.red)
                                        .offset(x: geo.size.width * 0.015)
                                       
                                    CompetitorScores(holeIndex: holeIndex, teamAssignment: .TeamsAB, totalType: .hole, teamScoreArray: scoreEntryVM.currentGame.game.teamBScoresArray)
                                        .frame(width: geo.size.width * 0.07, height: geo.size.height * 0.03, alignment: .center)
                                        .background(.red)
                                        .offset(x: geo.size.width * 0.026)
                                if scoreEntryVM.currentGame.game.teamAScoresArray[holeIndex].scoreCommitted && scoreEntryVM.currentGame.game.teamBScoresArray[holeIndex].scoreCommitted {
                                    HStack(spacing: 0){
                                        
                                        
                                            
                                            
                                          
//                                            Text(scoreEntryVM.currentGame.game.MatchResultHole1(currentGF: currentGF, holeIndex: holeIndex).0)
//                                                .frame(width: geo.size.width * 0.069, height: geo.size.height * 0.03, alignment: .center)
//                                                .offset(x: geo.size.width * 0.21)
//                                                .font(.caption)
//                                                //.foregroundColor(burntOrange)
//                                                .foregroundColor(Color[scoreEntryVM.currentGame.game.MatchResultHole1(currentGF: currentGF, holeIndex: holeIndex).3])
//                                        Text(scoreEntryVM.currentGame.game.MatchResultHole1(currentGF: currentGF, holeIndex: holeIndex).1)
//                                            .frame(width: geo.size.width * 0.069, height: geo.size.height * 0.03, alignment: .center)
//                                            .offset(x: geo.size.width * 0.21)
//                                            .font(.caption)
//                                            //.foregroundColor(burntOrange)
//                                            .foregroundColor(Color[scoreEntryVM.currentGame.game.MatchResultHole1(currentGF: currentGF, holeIndex: holeIndex).3])
//                                        Text(scoreEntryVM.currentGame.game.MatchResultHole1(currentGF: currentGF, holeIndex: holeIndex).2)
//                                            .frame(width: geo.size.width * 0.069, height: geo.size.height * 0.03, alignment: .center)
//                                            .offset(x: geo.size.width * 0.21)
//                                            .font(.caption)
//                                            //.foregroundColor(burntOrange)
//                                            .foregroundColor(Color[scoreEntryVM.currentGame.game.MatchResultHole1(currentGF: currentGF, holeIndex: holeIndex).3])
                                           
                                       
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
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                .offset(x: geo.size.width * 0.026)
                            }
                        }//switch
                    }
            }//foreach
               
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalDistance() ?? 0))
                            .frame(width:geo.size.width * 0.15)
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalPar() ?? 0))
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                  
                    // players front 9 totals
                
                    switch currentGF.assignShotsRecd{
                    case .Indiv:
                        HStack(spacing: 0){
                            Group{
                               
                                CompetitorScores(teamAssignment: .Indiv, totalType: .frontNine)
                            }//Group
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
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
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            
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
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            
                        }
                        .offset(x: geo.size.width * 0.12)
                        
                        .fontWeight(.semibold)
                        
                    }//switch
                    
                }//totals HStack
                
                let back9Holes = Array(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray ?? []).suffix(9)
                
                ForEach(0..<back9Holes.count, id: \.self) {holeIndex in
                    HStack(spacing:0){
                       
                        Text(Int(back9Holes[holeIndex + 9].number).formatted())
                            .frame(width: geo.size.width * 0.06, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                       
                        Text(Int(back9Holes[holeIndex + 9].distance).formatted())
                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                       
                        Text(Int(back9Holes[holeIndex + 9].par).formatted())
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        
                        Text(Int(back9Holes[holeIndex + 9].strokeIndex).formatted())
                            .frame(width: geo.size.width * 0.075, height: geo.size.height * 0.03)
                            .foregroundColor(burntOrange)
                        
                        switch currentGF.assignShotsRecd {
                            
                        case .Indiv:
                        
                            HStack(spacing:0){
                                Group{
                                    CompetitorScores(holeIndex: holeIndex+9, teamAssignment: .Indiv, totalType: .hole)
//
                                }
                                .foregroundColor(.blue)
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
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
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                .offset(x: geo.size.width * 0.026)
                            }
                        
                        case .TeamC:
                            HStack(spacing:geo.size.width * 0.048){
                                Spacer()
                                    .frame(width: geo.size.width * 0.011)
                                Group{
                                    CompetitorScores(holeIndex: holeIndex+9, teamAssignment: .TeamC, totalType: .hole, teamScoreArray: scoreEntryVM.currentGame.game.teamCScoresArray)
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                .offset(x: geo.size.width * 0.026)
                                
                            }
                        }
                    }
                }
                
                // hole back 9 totals
                    HStack(spacing:0){
      
                        HStack(spacing:0){
                            Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_back9.TotalDistance() ?? 0))
                                .frame(width:geo.size.width * 0.15)
                            Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_back9.TotalPar() ?? 0))
                                .frame(width:geo.size.width * 0.065)
                        }
                        .foregroundColor(darkTeal)
                        .fontWeight(.semibold)
                    
                        // players back 9 totals
                        
                        switch currentGF.assignShotsRecd {
                            
                        case .Indiv:
                            HStack(spacing: 0){
                                Group{

                                    CompetitorScores(teamAssignment: .Indiv, totalType: .backNine)
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
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
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                
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
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                
                            }
                            .offset(x: geo.size.width * 0.12)
                            
                            .fontWeight(.semibold)
                            
                            
                        }
                    }//back 9 HStack
               
                // players front 9 totals
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalDistance() ?? 0))
                            .frame(width:geo.size.width * 0.15)
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalPar() ?? 0))
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                  
                    // players fromt 9 totals
                    switch currentGF.assignShotsRecd {
                    case .Indiv:
                        HStack(spacing: 0){
                            Group{
                               
                                CompetitorScores(teamAssignment: .Indiv, totalType: .frontNine)
                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
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
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            
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
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            
                        }
                        .offset(x: geo.size.width * 0.12)
                        
                        .fontWeight(.semibold)
                        
                    }
                }//front 9 HStack
                
                // players  totals
                HStack(spacing:0){
                    //hole summary overall
                    HStack(spacing:0){
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.TotalDistance() ?? 0))
                            .frame(width:geo.size.width * 0.15)
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.TotalPar() ?? 0))
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    
                    
                    
                    // players overall totals
                    switch currentGF.assignShotsRecd {
                    case .Indiv:
                        HStack(spacing: 0){
                            Group{
                               // CompetitorScores_IndivTotal(competitors: scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF))
                                CompetitorScores(teamAssignment: .Indiv, totalType: .overall)
                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                        }
                        .offset(x: geo.size.width * 0.095)
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                    
                    case .TeamsAB:
                        HStack(spacing: geo.size.width * 0.048) {
                            Spacer()
                                .frame(width: geo.size.width * 0.011)
                            Group{
                                CompetitorScores(teamAssignment: .TeamsAB, totalType: .overall, subTotalGross: Int(scoreEntryVM.currentGame.game.teamAScoresArray.TotalGrossScore()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamAScoresArray.TotalStablefordPoints()))

                                CompetitorScores(teamAssignment: .TeamsAB, totalType: .overall, subTotalGross: Int(scoreEntryVM.currentGame.game.teamBScoresArray.TotalGrossScore()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamBScoresArray.TotalStablefordPoints()))

                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            
                        }
                        .offset(x: geo.size.width * 0.12)
                        
                        .fontWeight(.semibold)
                    case .TeamC:
                        HStack(spacing: geo.size.width * 0.048) {
                            Spacer()
                                .frame(width: geo.size.width * 0.011)
                            Group{
                                CompetitorScores(teamAssignment: .TeamC, totalType: .overall, subTotalGross: Int(scoreEntryVM.currentGame.game.teamCScoresArray.TotalGrossScore()), subTotalPoints: Int(scoreEntryVM.currentGame.game.teamCScoresArray.TotalStablefordPoints()))

                            }
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            
                        }
                        .offset(x: geo.size.width * 0.12)
                        
                        .fontWeight(.semibold)
                        
                    }
                } //overall total HStack
                
                
                
                HStack(spacing: 0){
                    Group{
                        ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self) {
                            Text($0.player?.Initials() ?? "")
                        }
                           
                    }
                    .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                }
                .offset(x: geo.size.width * 0.31)
                .foregroundColor(darkTeal)
                .fontWeight(.semibold)
                
            }
            
            
        }
    }
}

struct ScorecardScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        ScorecardScreen()
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
    }
}

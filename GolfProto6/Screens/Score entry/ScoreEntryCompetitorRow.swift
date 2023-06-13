//
//  ScoreEntryCompetitorRow.swift
//  GolfProto04
//
//  Created by Philip Nye on 26/04/2023.
//

import SwiftUI

struct ScoreEntryCompetitorRow: View {
   
    var competitorIndex: Int
    

    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    @Binding var needsRefresh: Bool
    var body: some View {
       
        ZStack{
            if currentGF.format == .sixPoint {
                Capsule()
                  
                    .fill(.blue)
                    .opacity(0.8)
                    .frame(width: 120, height: 32)
                    
                    .overlay(
                        Text(scoreEntryVM.currentGame.game.SixPointString(currentGF: currentGF, holeIndex: scoreEntryVM.holeIndex)[competitorIndex])
                            .foregroundColor(.white)
                            .font(.title3)
                    )
                
                    .offset(x:-115, y:40)
                
                
                
                
                
//                Text(scoreEntryVM.currentGame.game.SixPointString(currentGF: currentGF, holeIndex: scoreEntryVM.holeIndex)[competitorIndex])
//                    .frame(width: 80, height: 16)
//                    .padding(2)
//
//                    .background(.yellow)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 16)
//                            .stroke(darkTeal, lineWidth: 1)
//
//                    )
//                    .offset(x:-110, y:30)
                    
            }
            
            
                
                HStack(spacing: 5){
                
                
                
                
                //Text(scoreEntryVM.currentGame.game.competitorArray[competitorIndex].FirstName())
                // Text(scoreEntryVM.currentGame.game.competitorArray[competitorIndex].LastName().prefix(1).capitalized)
                
                Text(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].FirstName())
                Text(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].LastName().prefix(1).capitalized)
                
                
            }
            .frame(width: 130, height: 22, alignment: .leading)
            .font(.title)
            .font(.footnote.weight(.semibold))
            .foregroundColor(darkTeal)
            //.background(.yellow)
            //                .frame(width: geo.size.width * 0.4, height: 75,alignment: .leading)
            //.padding([.leading],10)
            .offset(x:-110, y:0)
               
        
            Spacer()
           // ZStack{
                
                HStack(spacing:25){
                    Button(action: {
                        scoreEntryVM.competitorsScores[scoreEntryVM.holeIndex][competitorIndex] -= 1
                        scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][competitorIndex] = true
                        scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                        needsRefresh.toggle()
                        //
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(gold)
                    }
                    //.disabled(score < 1)
                    
                    //
                    switch scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][competitorIndex] {// changes the opacity of the font depending on whther the score has been committed
                    case false:
                        CompetitorRowScoreBox(competitorIndex: competitorIndex, opacity: 0.5, needsRefresh: $needsRefresh)
                        
                        //
                    case true:
                        CompetitorRowScoreBox(competitorIndex: competitorIndex, opacity: 1.0, needsRefresh: $needsRefresh)
                    }
                    
                    Button(action: {
                        scoreEntryVM.competitorsScores[scoreEntryVM.holeIndex][competitorIndex] += 1
                        scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][competitorIndex] = true
                        scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                        needsRefresh.toggle()
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(gold)
                    }
                }//HStack
                .frame(width: 200, height: 75)
               // .background(.gray)
                .offset(x: 85, y: 0)
                
           // }//ZStack
        }
//        .onAppear(perform: {
//
//        })
        
    }
}
struct ScoreEntryCompetitorRow_Previews: PreviewProvider {
    static var previews: some View {
        ScoreEntryCompetitorRow(competitorIndex: 0, needsRefresh: .constant(false))
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
            
    }
}

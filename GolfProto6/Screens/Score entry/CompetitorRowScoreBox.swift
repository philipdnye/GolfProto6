//
//  CompetitorRowScoreBox.swift
//  GolfProto04
//
//  Created by Philip Nye on 27/04/2023.
//

import SwiftUI

struct CompetitorRowScoreBox: View {
    var competitorIndex: Int
    var opacity: Double = 0.0
    @Binding var needsRefresh: Bool
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    var body: some View {
        
        ZStack{
            Text(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].competitorScoresArray.TotalStablefordPoints().formatted())
           // Text("32")
                .frame(width:35, height:35)
                
                .padding(1)
                .background(lightTeal)
                
                .clipShape(Circle())
                .foregroundColor(.white)
                .font(.headline)
                .foregroundColor(darkTeal)
                .offset(x: -30, y: -30)
                .zIndex(1)
            Text(scoreEntryVM.competitorsScores[scoreEntryVM.holeIndex][competitorIndex].formatted())
            
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
                    scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][competitorIndex].toggle()
                    scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                    needsRefresh.toggle()
                })
            
            
            if currentGF.format == .sixPoint  && scoreEntryVM.currentGame.game.AllScoresCommitted(holeIndex: scoreEntryVM.holeIndex) {
                Text(scoreEntryVM.currentGame.game.SixPointString(currentGF: currentGF, holeIndex: scoreEntryVM.holeIndex)[competitorIndex+4])
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    .font(.callout)
                    .offset(x:21, y: -18)
            }
            
//            if currentGF.format == .sixPoint {
//                Text(SixPointString(currentGF: currentGF, holeIndex: scoreEntryVM.holeIndex))
//            }
            
            
            
            // need a switch here for match or strokeplay
            switch currentGF.playFormat {
          //  switch scoreEntryVM.currentGame.game.play_format {
            case .matchplay:
                
                


                if scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].competitorScoresArray[scoreEntryVM.holeIndex].shotsRecdHoleMatch != 0 {
                    Text(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].competitorScoresArray[scoreEntryVM.holeIndex].shotsRecdHoleMatch.formatted())
                        .offset(x: 22, y: 18)
                        .foregroundColor(burntOrange)
                        .fontWeight(.semibold)
                }
                
            case .strokeplay:
                
                if scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].competitorScoresArray[scoreEntryVM.holeIndex].shotsRecdHoleStroke != 0 {
                    Text(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].competitorScoresArray[scoreEntryVM.holeIndex].shotsRecdHoleStroke.formatted())
                        .offset(x: 22, y: 18)
                        .foregroundColor(burntOrange)
                        .fontWeight(.semibold)
                }
                
                
            }
        }
    }
}

struct CompetitorRowScoreBox_Previews: PreviewProvider {
    static var previews: some View {
        CompetitorRowScoreBox(competitorIndex: 0, opacity: 1, needsRefresh: .constant(false))
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
    }
}

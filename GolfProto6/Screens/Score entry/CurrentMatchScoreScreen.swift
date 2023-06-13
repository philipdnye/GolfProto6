//
//  CurrentMatchScoreScreen.swift
//  GolfProto05
//
//  Created by Philip Nye on 16/05/2023.
//

import SwiftUI

struct CurrentMatchScoreScreen: View {
    @EnvironmentObject var currentGF: CurrentGameFormat
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @Binding var neeedsRefresh: Bool
    var game: GameViewModel
    var body: some View {
        switch currentGF.format {
        case _ where currentGF.format == .fourPlayScramble || currentGF.format == .threePlayScramble || currentGF.format == .twoPlayScramble:
            let netScore = Double(game.game.teamScoresArray.TotalGrossScore()) - game.game.TotalPlayingHandicapC()
          
            
            
           let scoreToPar = Int(game.game.teamScoresArray.TotalGrossScore()) - Int(game.game.teamScoresArray.TotalParSoFar())
            
            
            HStack {
                Text("Gross: \(game.game.teamScoresArray.TotalGrossScore().formatted())")
                    .foregroundColor(darkTeal)
                Text(scoreToPar.ScoreToParString())
                    .foregroundColor(burntOrange)
                    .font(.title2)
                Text(" - ")
                Text(String(format: "%.2f", game.game.TotalPlayingHandicapC()))
                Text(" = ")
                Text(String(format: "%.2f", netScore))
                    .foregroundColor(burntOrange)
                    .font(.title2)
                
                
            }
        case .sixPoint:
            VStack{
//                Text(game.game.SixPointString(currentGF: currentGF, holeIndex: scoreEntryVM.holeIndex)[0])
//                Text(game.game.SixPointString(currentGF: currentGF, holeIndex: scoreEntryVM.holeIndex)[1])
//                Text(game.game.SixPointString(currentGF: currentGF, holeIndex: scoreEntryVM.holeIndex)[2])
                Text(game.game.SixPointString(currentGF: currentGF, holeIndex: scoreEntryVM.holeIndex)[3])

            }
            
            
            
        default: // for everything other than a texas scramble or sixpoint
            let currentMatchScore = game.game.CalcCurrentMatchScore(currentGF: currentGF, byHole: false, holeIndex: nil).0
            let holesPlayed = game.game.CalcCurrentMatchScore(currentGF: currentGF, byHole: false, holeIndex: nil).1
            HStack{
                Text(game.game.CurrentMatchScoreString(currentMatchScore: currentMatchScore, holesPlayed: holesPlayed, currentGF: currentGF).0)
                Text(game.game.CurrentMatchScoreString(currentMatchScore: currentMatchScore, holesPlayed: holesPlayed, currentGF: currentGF).1)
                
                Text(neeedsRefresh.description)
                    .frame(width: 0, height: 0)
                    .opacity(0)
            }
        }
    }
}

struct CurrentMatchScoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        CurrentMatchScoreScreen(neeedsRefresh: .constant(false),game: game)
            .environmentObject(CurrentGameFormat())
            .environmentObject(ScoreEntryViewModel())
    }
}

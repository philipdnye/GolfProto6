//
//  GameSummaryForDetailScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 18/04/2023.
//

import SwiftUI

struct GameSummaryForDetailScreen: View {
    @EnvironmentObject var currentGF: CurrentGameFormat
    let game: GameViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing: 0){
                
                
                Text(game.name.capitalized)
                    .font(.title2)
                    .padding([.leading, .top],15)
                
                Spacer()
                Text(game.date.formatted(.dateTime.day().month().year()))
                    .font(.headline)
                    .padding([.trailing, .top],15)
            }
            
            .font(.footnote.weight(.semibold))
            .foregroundColor(darkTeal)
            
            HStack{
                
                Text(game.clubName)
                    .padding([.leading],15)
                    .padding([.top],0)
                    .font(.title2)
                    .font(.footnote.weight(.semibold))
                if game.defaultTeeBox.course?.club?.courseArray.count ?? 0 > 1 {
                    Text(game.courseName)
                }
            }
            .foregroundColor(darkTeal)
            //if game.TeeBoxesAllSame() {
            HStack(spacing: 0){
                Group{
                    Text("\(game.defaultTeeBoxColour.capitalized) tees")
                    Spacer()
                        .frame(width: 4)
                    Text("\(String(game.defaultTeeBox.TotalDistance()))")//need to add in distance metric
                    Text(game.game.defaultTeeBox?.course?.club?.dist_metric.stringValueInitial() ?? "y")
                    Spacer()
                        .frame(width: 4)
                }
                Group{
                    Text("Par: \(game.defaultTeeBox.TotalPar())")
                    Spacer()
                        .frame(width: 4)
                    Text("SR \(game.defaultTeeBox.slopeRating)")
                    Spacer()
                        .frame(width: 4)
                    Text("CR \(String(format: "%.1f", game.defaultTeeBox.courseRating))")
                    Spacer()
                }
                //                gameStatus
                //                    .foregroundColor(burntOrange)
                //                    .padding([.trailing],5)
            }
            .font(.caption)
            .foregroundColor(darkTeal)
            .padding([.leading], 15)
            //        } else {
            //            Text("Mixed tees")
            //                .font(.caption)
            //                .foregroundColor(darkTeal)
            //                .padding([.leading], 15)
            //        }
            //        Spacer()
            //            .frame(height:5)
            //        Divider()
            Spacer()
                .frame(height:10)
            HStack(spacing:0){
                Text("Starting hole: \(game.startingHoleString)")
                Spacer()
                    .frame(width:10)
                Text(game.durationName)
              Spacer()
            }
            .font(.caption)
            .foregroundColor(darkTeal)
            .padding([.leading], 15)
            
            Spacer()
                .frame(height:6)
            HStack(spacing:0){
                Text(game.succinctDescription)
                Spacer()
                    .frame(width:10)
                Text(currentGF.playFormat.stringValue())
                Spacer()
                    .frame(width:10)
                Text(game.scoreFormatName)
                Spacer()
                    .frame(width:10)
                Text(game.handicapFormatName)
                
              Spacer()
            }
            .font(.subheadline)
            .foregroundColor(darkTeal)
            .padding([.leading], 15)
            Spacer()
                .frame(height:6)
        }
    }
}

struct GameSummaryForDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        GameSummaryForDetailScreen(game:game)
            .environmentObject(CurrentGameFormat())
    }
}
//                Text(game.handicapFormatName)
//                Text(game.scoreFormatName)
//                Text(game.succinctDescription)
//            }
//            Group {
//                Text(currentGF.description.description)
//                Text(currentGF.playFormat.stringValue())
//
//
//            }

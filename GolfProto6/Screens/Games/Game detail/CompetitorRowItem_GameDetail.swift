//
//  CompetitorRowItem_GameDetail.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct CompetitorRowItem_GameDetail: View {
    @EnvironmentObject var currentGF: CurrentGameFormat
    var competitor: Competitor
    var game: GameViewModel
    @Binding var needsRefresh: Bool
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0){
                Text(needsRefresh.description)// this refreshes screen when teebox changed on pop up sheet
                    .frame(width:0, height:0)
                    .opacity(0)
                
                
                Group{
                    Text(competitor.FirstName())
                        .frame(height: 30)
                    Spacer()
                        .frame(width: 5)
                    Text(competitor.LastName())
                    Spacer()
                        .frame(width: 5)
                   
                    
                    
                }
                
                
                .foregroundColor(darkTeal)
                .font(.title3)
                //Text(competitor.TeeBoxColour())
                Spacer()
                if competitor.shotsRecdMatch != 0 {
                    Text("(\(competitor.shotsRecdMatch.formatted()))")
                        .foregroundColor(burntOrange)
                        .font(.title3)
                }
                Spacer()
                    .frame(width: 1)
                if currentGF.assignShotsRecd != .TeamC && currentGF.assignShotsRecd != .TeamsAB  {
                    Text(round(competitor.TotalPlayingHandicap(currentGF: currentGF)).formatted())
                        .frame(width: 30, alignment: .trailing)
                        .foregroundColor(darkTeal)
                        .font(.title3)
                } else {
                    Text(String(format: "%.2f",competitor.TotalPlayingHandicapUnrounded(currentGF: currentGF)))
                        .frame(width: 70, alignment: .trailing)
                        .foregroundColor(darkTeal)
                        .font(.title3)
                    
                }
                Spacer()
                    .frame(width: 5)
                HStack{
                    if currentGF.assignTeamGrouping == Assignment.TeamsAB {
                        ZStack{
                            Text(competitor.team_String.stringValueInitial())
                                .font(.headline)
                                .zIndex(2)
                            Circle()
                                .fill(.white)
                            
                                .frame(width: 23, height: 23)
                                .zIndex(1)
                            Circle()
                                .fill(.gray)
                            
                                .frame(width: 24, height: 24)
                                .zIndex(0)
                            
                        }
                    }
                }.frame(width:30, height:30)
                    .background(Color(competitor.teeBox?.teeBoxColor ?? UIColor(.clear)))
                    .border(.black.opacity(0.2))
            }
            HStack{
                Text("Handicap index: (\(competitor.handicapIndex.formatted()))")
                   
                Text("Course handicap: \(round(competitor.courseHandicap).formatted())")
            }
            .foregroundColor(burntOrange)
            .font(.caption2)
            HStack{
                
                
                switch currentGF.assignShotsRecd {
                case .TeamC:
                    Text("Playing handicap: \((competitor.handicapAllowance as NSNumber).getPercentage()) * \(String(format: "%.1f", round(competitor.courseHandicap))) = \(String(format: "%.2f", competitor.playingHandicap))")
                case .Indiv:
                    Text("Playing handicap: \((competitor.handicapAllowance as NSNumber).getPercentage()) * \(String(format: "%.1f", round(competitor.courseHandicap))) = \(String(format: "%.2f", competitor.playingHandicap)) (\(String(format: "%.0f", round(competitor.playingHandicap))))")
                case .TeamsAB:
                    Text("Playing handicap: \((competitor.handicapAllowance as NSNumber).getPercentage()) * \(String(format: "%.1f", round(competitor.courseHandicap))) = \(String(format: "%.2f", competitor.playingHandicap))")
                    
                    
                }
        
            }
            .font(.caption2)
            .foregroundColor(darkTeal)
            
          
       //******REWORK THIS AS A SWITCH STATEENT***************
            
            switch currentGF.assignShotsRecd {
            case .TeamC:
                if game.game.TeeBoxesAllSame() == false && competitor.diffTeesXShots != 0 {
                    Group{
                        Text("Extra shots: \(String(format: "%.2f", competitor.diffTeesXShots)) * \(String(format: "%.2f", currentGF.extraShotsTeamAdj)) = \(String(format: "%.2f",competitor.TotalAdjustedExtraShotsUnrounded(currentGF: currentGF)))")
                        
                        Text("Adjusted playing handicap: \(String(format: "%.2f" ,competitor.TotalPlayingHandicapUnrounded(currentGF: currentGF)))")
                    }
                    .font(.caption2)
                    .foregroundColor(burntOrange)
                }
            case .TeamsAB:
                if game.game.TeeBoxesAllSame() == false && competitor.diffTeesXShots != 0 {
                    Group{
                       // Text("Extra shots: \(String(format: "%.0f", competitor.diffTeesXShots))")
                        Text("Extra shots: \(String(format: "%.2f", competitor.diffTeesXShots)) * \(String(format: "%.2f", currentGF.extraShotsTeamAdj)) = \(String(format: "%.2f",competitor.TotalAdjustedExtraShotsUnrounded(currentGF: currentGF)))")
                        
                        Text("Adjusted playing handicap: \(String(format: "%.2f" ,competitor.TotalPlayingHandicapUnrounded(currentGF: currentGF)))")
                    }
                    .font(.caption2)
                    .foregroundColor(burntOrange)
                }
            case .Indiv:
                if game.game.TeeBoxesAllSame() == false && competitor.diffTeesXShots != 0 {
                    Group{
                        Text("Extra shots: \(String(format: "%.0f", competitor.diffTeesXShots))")
                        
                        Text("Adjusted playing handicap: \(String(format: "%.0f" ,competitor.TotalPlayingHandicap(currentGF: currentGF)))")
                    }
                    .font(.caption2)
                    .foregroundColor(burntOrange)
                }
            }
            
            
            
            
            
            
            
            
//        if currentGF.assignShotsRecd != .TeamC {
//
//            if game.game.TeeBoxesAllSame() == false && competitor.diffTeesXShots != 0 {
//                Group{
//                    Text("Extra shots: \(String(format: "%.0f", competitor.diffTeesXShots))")
//
//                    Text("Adjusted playing handicap: \(String(format: "%.0f" ,competitor.TotalPlayingHandicap(currentGF: currentGF)))")
//                }
//                .font(.caption2)
//                .foregroundColor(burntOrange)
//            }
//
//
//        } else {
//
//
//            if game.game.TeeBoxesAllSame() == false && competitor.diffTeesXShots != 0 {
//                Group{
//                    Text("Extra shots: \(String(format: "%.2f", competitor.diffTeesXShots)) * \(String(format: "%.2f", currentGF.extraShotsTeamAdj)) = \(String(format: "%.2f",competitor.TotalAdjustedExtraShotsUnrounded(currentGF: currentGF)))")
//
//                    Text("Adjusted playing handicap: \(String(format: "%.2f" ,competitor.TotalPlayingHandicapUnrounded(currentGF: currentGF)))")
//                }
//                .font(.caption2)
//                .foregroundColor(burntOrange)
//            }
//
//
//        }
            
          //********REWORK ABOVE AS SWITCH STATEMENT************
            
            
            if game.game.TeeBoxesAllSame() == false && competitor.teeBox != game.defaultTeeBox {
                
                    HStack(spacing: 0){
                        Text("\(competitor.TeeBoxColour()) tees ")
                        Text(String(competitor.teeBox?.TotalDistance() ?? 0))
                        Text(game.game.defaultTeeBox?.course?.club?.dist_metric.stringValueInitial() ?? "y")
                        Spacer()
                            .frame(width: 4)
                        Text("Par: \(String(competitor.teeBox?.TotalPar() ?? 0))")
                        Spacer()
                            .frame(width: 4)
                        Text("SR \(String(competitor.SlopeRating()))")
                        Spacer()
                            .frame(width: 4)
                        Text("CR \(String(competitor.CourseRating()))")
                        
                       
                    }
                
                    .font(.caption2)
                    .foregroundColor(darkTeal)
            }
            
            
            if competitor.shotsRecdMatch > 1 {
                Text("Shots received: \(competitor.shotsRecdMatch.formatted()) shots")
                    .font(.caption)
                    .foregroundColor(darkTeal)
            } else if competitor.shotsRecdMatch == 1 {
                Text("Shots received: \(competitor.shotsRecdMatch.formatted()) shot")
                    .font(.caption)
                    .foregroundColor(darkTeal)
            }
            
            Spacer()
        }//VStack
        
        
    }
}

struct CompetitorRowItem_GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext)).competitor
       
        
        
        
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
//        competitor.player?.firstName = "Philip"
//        competitor.player?.lastName = "Birkenstock"
        
        CompetitorRowItem_GameDetail(competitor: competitor,game: game, needsRefresh: .constant(false))
            .environmentObject(CurrentGameFormat())
    }
}

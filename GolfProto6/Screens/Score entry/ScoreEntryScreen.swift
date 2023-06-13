//
//  ScoreEntryScreen.swift
//  GolfProto04
//
//  Created by Philip Nye on 25/04/2023.
//

import SwiftUI

struct ScoreEntryScreen: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    @Environment(\.dismiss) private var dismiss
    @State private var showHoleNavigator: Bool = false
    @State private var isShowingDialogueCommitScores: Bool = false
    @State private var isPresentedSheetScoreCard: Bool = false
    @State private var isPresentedSheetScoreCardStroke: Bool = false
    @State private var needsRefresh: Bool = false
    
    var game: GameViewModel
    
    
    
    
    private var showTotalsButton: some View {
        AnyView(Button(action: setToPar){
            ZStack{
                Image(systemName: "circle.fill")
                    
                    
                    .foregroundColor(darkTeal)
                    .opacity(0.50)
                Text(String((scoreEntryVM.currentGame.game.defaultTeeBox?.TotalPar())!))
//                Text("36")
                                    .font(.callout)
                                    
                                    .foregroundColor(.white)
                
                Text("Totals")
                    .font(.caption2)
                    .offset(x:-1, y:17)
                    .foregroundColor(darkTeal)
                
                
            }
        }
        )
    }
    
    private var showToParButton: some View {
        AnyView(Button(action: setToPar){
            ZStack{
                Image(systemName: "circle.fill")
                    
                    
                    .foregroundColor(darkTeal)
                    .opacity(0.50)
                    Text("+/-")
                                    .font(.callout)
                                    
                                    .foregroundColor(.white)
                
                Text("Par")
                    .font(.caption2)
                    .offset(x:-1, y:17)
                    .foregroundColor(darkTeal)
                
                
            }
        }
        )
    }
    
    
    
    
    private var scoreCardButton: some View {
        AnyView(Button(action: showScorecard){
            ZStack {
                Image(systemName: "list.number")
                Text("Match")
                    .font(.caption2)
                    .offset(x:-1, y:17)
                    .foregroundColor(darkTeal)
            }
        })
    }
    
    
    
    private var scoreCardButtonStroke: some View {
        AnyView(Button(action: showScorecardStroke){
            ZStack {
                Image(systemName: "list.number")
                
                    Text("Stroke")
               
                    .font(.caption2)
                    .offset(x:-1, y:17)
                    .foregroundColor(darkTeal)
            }
            
        })
    }
    private var scoreCardButtonStrokeWithOutMatch: some View {
        AnyView(Button(action: showScorecardStroke){
          
                Image(systemName: "list.number")
                
                    
                
//                    .font(.caption2)
//                    .offset(x:-1, y:17)
//                    .foregroundColor(darkTeal)
                        
            
        })
    }
    private func showScorecard () {
        isPresentedSheetScoreCard.toggle()
    }
    private func showScorecardStroke () {
        isPresentedSheetScoreCardStroke.toggle()
    }
    private func setToPar () {
        scoreEntryVM.scoreButton.toggle()
    }
    var body: some View {
        ZStack{
//            Text(needsRefresh.description)
//                .frame(width:0, height: 0)
//                .opacity(0)
            GeometryReader { geo in
                HoleNavigatorPopUp(scoreEntryVM: scoreEntryVM,showHoleNavigator: $showHoleNavigator)
                    .zIndex(1)
                    .offset(x:geo.size.width * 0.1, y: geo.size.height * 0.195)
                
                
                HStack(spacing: 0){
                    
                    Text(game.name)
                        .frame(width: geo.size.width * 0.48, alignment: .leading)
                        .offset(x:geo.size.width * 0.02, y: geo.size.height * 0.02)
                    Text(game.game.scoreEntryTeeBox?.course?.club?.wrappedName ?? "")
                        .frame(width: geo.size.width * 0.48, alignment: .trailing)
                        .offset(x:geo.size.width * 0.02, y: geo.size.height * 0.02)
                }
                .font(.title3)
                .foregroundColor(darkTeal)
                .zIndex(0)
                
                HStack(spacing: 0){
                    Text("\(game.game.scoreEntryTeeBox?.wrappedColour.capitalizingFirstLetter() ?? "no teebox found") tees") //teeBox for game
                        .frame(width:geo.size.width * 0.26, alignment: .leading)
                    
                    Text(String(game.game.scoreEntryTeeBox?.TotalDistance() ?? 0) + (game.game.scoreEntryTeeBox?.course?.club?.dist_metric.stringValueInitial() ?? ""))
                        .frame(width:geo.size.width * 0.18, alignment: .leading)
                    
                    Text("Par: \(game.game.scoreEntryTeeBox?.TotalPar() ?? 0)")
                        .frame(width:geo.size.width * 0.2, alignment: .leading)
                    
                    
                    
                    //                    Text(game.game.scoreEntryTeeBox?.course?.name ?? "")
                    //                        .frame(width:geo.size.width * 0.32, alignment: .trailing)
                    
                }
                .zIndex(0)
                .offset(x:geo.size.width * 0.02, y: geo.size.height * 0.058)
                .foregroundColor(darkTeal)
                HStack(spacing:0){
                    Text(game.game.game_format.stringValue())
                        .frame(width: geo.size.width * 0.37, alignment: .leading)
                        .offset(x:geo.size.width * 0.02, y: geo.size.height * 0.088)
                    Text(currentGF.playFormat.stringValue())
                        .frame(width: geo.size.width * 0.21, alignment: .center)
                        .offset(x:geo.size.width * 0.00, y: geo.size.height * 0.088)
                    Text(game.game.sc_format.stringValue())
                        .frame(width: geo.size.width * 0.21, alignment: .center)
                        .offset(x:geo.size.width * 0.00, y: geo.size.height * 0.088)
                    Text(game.game.hcap_format.stringValue())
                        .frame(width: geo.size.width * 0.21, alignment: .center)
                    
                    
                        .offset(x:geo.size.width * 0.00, y: geo.size.height * 0.088)
                }
                .font(.subheadline)
                .foregroundColor(darkTeal)
                .zIndex(0)
                HStack(spacing: 0){
                    Text("Hole ")
                    Text(String(scoreEntryVM.holeIndex + 1))
                    Spacer()
                        .frame(width:3)
                    Button {
                        showHoleNavigator.toggle()
                    } label: {
                        
                        
                        
                        Label("", systemImage: "arrowtriangle.down.fill")
                            .font(.system(size: 20))
                        
                    }
                    
                    
                    
                    .background(burntOrange)
                    
                    
                    .foregroundColor(.white)
                    
                    
                    
                }
                .frame(width: geo.size.width * 1, height: 50)
                .font(.title)
                .background(burntOrange)
                .foregroundColor(.white)
                .offset(x:0, y: geo.size.height * 0.15)
                .zIndex(0)
                
                
                
                
                
                HStack{
                    Text(String(game.game.scoreEntryTeeBox?.holesArray[scoreEntryVM.holeIndex].distance ?? 0))
                    Text("Par \(game.game.scoreEntryTeeBox?.holesArray[scoreEntryVM.holeIndex].par ?? 0)")
                    Text("S.I. \(game.game.scoreEntryTeeBox?.holesArray[scoreEntryVM.holeIndex].strokeIndex ?? 0)")
                }
                .frame(width: geo.size.width * 1, height: 50)
                .font(.title2)
                .background(gold)
                .foregroundColor(darkTeal)
                .offset(x:0, y: geo.size.height * 0.23)
                .zIndex(0)
                
                
                
                if scoreEntryVM.holeIndex != 0 {
                    
                    Button("< Hole \(scoreEntryVM.holeIndex)"){
                        
                        scoreEntryVM.holeIndex -= 1
                        //games.allGames[scoreEntryVar.CGI].lastHoleIndex = scoreEntryVar.holeIndex
                        
                    }
                    .buttonStyle(HoleButton())
                    
                    .frame(width: geo.size.width * 0.27, height: 50)
                    .offset(x:geo.size.width * 0.05, y: geo.size.height * 0.15)
                    //.padding([.leading], 25)
                    .disabled(scoreEntryVM.holeIndex == 0)
                    .zIndex(0)
                }
                
                if scoreEntryVM.holeIndex != 17 {
                    
                    Button("Hole \(scoreEntryVM.holeIndex + 2) >"){
                        
                        //code here to check to see if any of score have been changed -> dialouge box
                        if scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex].allSatisfy({$0 == false}){
                            isShowingDialogueCommitScores.toggle()
                            
                        } else {
                            // if they aren't all false it suggests that user has chnaged the ones they need to so move forward and commit all scores
                            
                            //                            ***** NEED TO SWITCH HERE BETWEEN COMPETITORS AND TEAMS******   STILL TO DO
                            
                            
                            
                            switch currentGF.assignShotsRecd {
                                //                            FOR COMPETITORS *****
                            case .Indiv:
                                for i in 0..<game.game.competitorArray.count {
                                    scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][i] = true
                                }
                                
                                scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                                needsRefresh.toggle()
                                //                           FOR COMPETITORS
                            case .TeamsAB:
                                switch currentGF.noOfPlayersNeeded {
                                case 4:
                                    for i in 0..<2{
                                        scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][i] = true
                                    }
                                    scoreEntryVM.saveCompetitorsScoreTeam()
                                    needsRefresh.toggle()
                                case 2:
                                    scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][0] = true
                                    scoreEntryVM.saveCompetitorsScoreTeam2P()
                                    needsRefresh.toggle()
                                default:
                                    break
                                }
                            case .TeamC:
                                
                                scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][0] = true
                                scoreEntryVM.saveCompetitorScoreTeamC()
                                needsRefresh.toggle()
                                
                                
                            }
                            scoreEntryVM.holeIndex += 1
                        }
                        
                        
                        
                        //games.allGames[scoreEntryVar.CGI].lastHoleIndex = scoreEntryVar.holeIndex
                        
                    }
                    .buttonStyle(HoleButton())
                    
                    .frame(width: geo.size.width * 0.27, height: 50)
                    .offset(x:geo.size.width * 0.68, y: geo.size.height * 0.15)
                    //.padding([.leading], 25)
                    .disabled(scoreEntryVM.holeIndex == 17)
                    .zIndex(0)
                    .confirmationDialog("Confirm scores", isPresented: $isShowingDialogueCommitScores, actions: {
                        Button("Commit scores", role: .destructive){
                            //                            ***** NEED TO SWITCH HERE BETWEEN COMPETITORS AND TEAMS******   STILL TO DO
                            switch currentGF.assignShotsRecd {
                                //                            FOR COMPETITORS *****
                            case .Indiv:
                                
                                
                                for i in 0..<game.game.competitorArray.count {
                                    scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][i] = true
                                }
                                scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                                needsRefresh.toggle()
                            case .TeamsAB:
                                switch currentGF.noOfPlayersNeeded {
                                case 4:
                                    for i in 0..<2{
                                        scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][i] = true
                                    }
                                    scoreEntryVM.saveCompetitorsScoreTeam()
                                    needsRefresh.toggle()
                                case 2:
                                    scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][0] = true
                                    scoreEntryVM.saveCompetitorsScoreTeam2P()
                                    needsRefresh.toggle()
                                default:
                                    break
                                }
                            
                            case .TeamC:
                               
                                
                                scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][0] = true
                                scoreEntryVM.saveCompetitorScoreTeamC()
                                needsRefresh.toggle()
                                
                            }
                            scoreEntryVM.holeIndex += 1
                        }
                        
                    }, message: {Text("You haven't amended any scores on this hole. Commit these scores and continue to the next hole?")})
                    
                }
                //               SWITCH NEEDED HERE FOR COMPETITORS OR TEAMS - STILL TO DO NEED TO CREATE NEW SCOREENTRY TEAMROW AND NEW TEAM ROWSCOREBOX
                
                switch currentGF.assignShotsRecd {
                case .Indiv:
                    ForEach(Array(game.game.SortedCompetitors(currentGF: currentGF).enumerated()), id: \.element){index, item in
                        ScoreEntryCompetitorRow(competitorIndex: index, needsRefresh: $needsRefresh)
                            .frame(width: geo.size.width * 0.95, height: 75)
                            .offset(x: 0, y: geo.size.height * CGFloat(((Double(index)+1)*0.15)+0.2))
                        
                        
                    }
                case .TeamsAB:
                    ForEach(Array(game.game.SortedCompetitors(currentGF: currentGF).enumerated()), id: \.element){index, item in
                        ScoreEntryTeamRow(competitorIndex: index)
                            .frame(width: geo.size.width * 0.95, height: 75)
                            .offset(x: 0, y: geo.size.height * CGFloat(((Double(index)+1)*0.15)+0.2))
                    }
                    
                    
                    //switch here between 2 and 4 players
                    
                    switch currentGF.noOfPlayersNeeded {
                    case 4:
                        ForEach(0..<2){teamIndex in
                            ScoreEntryTeamRowButtons(needsRefresh: $needsRefresh, teamIndex: teamIndex)
                                .frame(width: geo.size.width * 0.95, height: 75)
                                .offset(x: geo.size.width * 0.2, y: geo.size.height * CGFloat(((Double(teamIndex)+1)*0.3)+0.13))
                        }
                    case 2:
                        ScoreEntryTeamRowButtons(needsRefresh: $needsRefresh, teamIndex: 0)
                            .frame(width: geo.size.width * 0.95, height: 75)
                            .offset(x: geo.size.width * 0.2, y: geo.size.height * CGFloat(((Double(0)+1)*0.3)+0.13))
                    default:
                        EmptyView()
                    }
                    
                case .TeamC:
                    ForEach(Array(game.game.SortedCompetitors(currentGF: currentGF).enumerated()), id: \.element){index, item in
                        ScoreEntryTeamRow(competitorIndex: index)
                            .frame(width: geo.size.width * 0.95, height: 75)
                            .offset(x: 0, y: geo.size.height * CGFloat(((Double(index)+1)*0.15)+0.2))
                    }
                    
                    ScoreEntryTeamRowButtons(needsRefresh: $needsRefresh, teamIndex: 0)
                        .frame(width: geo.size.width * 0.95, height: 75)
                        .offset(x: geo.size.width * 0.2, y: geo.size.height * CGFloat(((Double(0.5)+1)*0.3)+0.13))
                    
                    
                    
                    
                }
                // switch here on game format for different matchplay results/scores
                //               SWITCH NEEDED HERE FOR COMPETITORS OR TEAMS
                
                //***************************
                switch currentGF.assignShotsRecd {
                case .Indiv:



                    switch currentGF.format{


                    case .sixPoint:
                        CurrentMatchScoreScreen(neeedsRefresh: $needsRefresh,game: game)
                        .frame(width: geo.size.width * 0.95, height: 140)
                        .offset(x: 0, y: geo.size.height * 0.79)
                        .foregroundColor(darkTeal)


                    default:
                       
                        CurrentMatchScoreScreen(neeedsRefresh: $needsRefresh,game: game)
                        
                        .frame(width: geo.size.width * 0.95, height: 35)
                        .offset(x: 0, y: geo.size.height * 0.93)
                        .foregroundColor(darkTeal)

                    }//playformat switch
                case .TeamsAB:
                    switch currentGF.format {
                    case .fourSomesMatch:
                        
                       

                        HStack{
                            CurrentMatchScoreScreen(neeedsRefresh: $needsRefresh,game: game)


                        }
                        .frame(width: geo.size.width * 1, height: 50)
                        .font(.title3)
                        //.fontWeight(.semibold)
                        .background(gold)
                        .offset(x: 0, y: geo.size.height * 0.93)
                        .foregroundColor(darkTeal)
                        .zIndex(0)
                    default:
                        EmptyView()
                    }
                case .TeamC://placeholder for texas scramble
                    CurrentMatchScoreScreen(neeedsRefresh: $needsRefresh,game: game)
                        .frame(width: geo.size.width * 0.95, height: 35)
                        .offset(x: 0, y: geo.size.height * 0.93)
                        .foregroundColor(darkTeal)

                    
                }
                //**************************

                
                
                
                
                
            }//geo
            
        }
       

        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    //code here to save competitorscores
                    //               SWITCH NEEDED HERE FOR COMPETITORS OR TEAMS
                    switch currentGF.assignShotsRecd {
                    case .Indiv:
                        scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                    case .TeamsAB:
                        scoreEntryVM.saveCompetitorsScoreTeam()
                    case .TeamC:
                        scoreEntryVM.saveCompetitorScoreTeamC()
                    }
                    dismiss()
                } label: {
                    
                    Text("Pause game")
                                            
                }
                
                }
            
            
            ToolbarItem(placement: .navigationBarLeading){
                HStack{
                    if currentGF.playFormat == .matchplay {
                        scoreCardButtonStroke
                        scoreCardButton
                        
                    } else {
                        scoreCardButtonStrokeWithOutMatch
                    }
                }
            }
            if scoreEntryVM.scoreButton == false {
                ToolbarItem(placement: .navigationBarLeading){
                    showTotalsButton
                }
            }
            
            if scoreEntryVM.scoreButton {
                ToolbarItem(placement: .navigationBarLeading){
                    showToParButton
                }
            }
            }
        
        
        
        
        
        .sheet(isPresented: $isPresentedSheetScoreCard, onDismiss: {
            
           
        }, content: {
            // might need a switch here for different scorecards
           ScorecardScreen()
        })
        .sheet(isPresented: $isPresentedSheetScoreCardStroke, onDismiss: {
            
           
        }, content: {
            // might need a switch here for different scorecards
           ScorecardScreenStroke()
        })
        
    }
}

struct ScoreEntryScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        ScoreEntryScreen(game: game)
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
            
    }
}

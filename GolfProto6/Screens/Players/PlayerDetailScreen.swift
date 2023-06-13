//
//  PlayerDetailScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 23/03/2023.
//

import SwiftUI

struct PlayerDetailScreen: View {
    @StateObject private var handicapListVM = HandicapListViewModel()
    @State private var showingSheet: Bool = false
    @Binding var needsRefresh: Bool
    let player: PlayerViewModel
    
    private func onAdd() {
        showingSheet = true
    }
   
    private var addButton: some View {
       AnyView(Button(action: onAdd) {Image(systemName: "plus")})
        }
    
    
    var body: some View {
       
            Form{
                Section {
           
                    ForEach(player.player.handicapArray.sorted(by: {$0.startDate ?? Date() > $1.startDate ?? Date()})) {handicap in
                        HStack{
                            Text(handicap.startDate?.formatted(.dateTime.day().month().year()) ?? "")
                            Spacer()
                            Text(String(format: "%.1f", handicap.handicapIndex))
                                .frame(width:40,alignment: .trailing)
                                .foregroundColor(.orange)
                        }
                    }
                   // .onDelete(perform: <#T##Optional<(IndexSet) -> Void>##Optional<(IndexSet) -> Void>##(IndexSet) -> Void#>)
                    
                    
                }
            header: {
                Text("HANDICAP HISTORY")
            } footer: {
                Text("Add a new handicap index using the '+' button")
            }
                Section {
                    // list of games for player
                    ForEach(player.player.competitorArray, id: \.self){
                        Text($0.game?.name ?? "")
                    }
                    
                    
                    
                }
            }
//            .sheet(isPresented: $showingSheet) {
//                AddHandicapScreen(player: player)
//                
//            }
            
            .sheet(isPresented: $showingSheet, onDismiss: {
                handicapListVM.getHandicapsByPlayer(vm: player)
                needsRefresh.toggle()
            }, content: {
                AddHandicapScreen(player: player)
            })
            
            
            
            
            
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }
            }
            //        .embedInNavigationView()
            .navigationTitle("\(player.firstName.capitalized) \(player.lastName.capitalized)")
            .navigationBarTitleDisplayMode(.inline)
            
            
            .onAppear(perform:{
                handicapListVM.getHandicapsByPlayer(vm: player)
            })
        
    }
}

struct PlayerDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let player = PlayerViewModel(player: Player(context: CoreDataManager.shared.viewContext))
        PlayerDetailScreen(needsRefresh: .constant(false),player: player)
    }
}

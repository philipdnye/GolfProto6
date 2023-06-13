//
//  PlayerListScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 23/03/2023.
//

import SwiftUI

struct PlayerListScreen: View {
    @StateObject private var playerListVM = PlayerListViewModel()
    @State private var isPresented: Bool = false
    @State private var needsRefresh: Bool = false
    private func deletePlayer(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let player = playerListVM.players[index]
            // delete the club
            playerListVM.deletePlayer(player: player)
            // get all clubs
            playerListVM.getAllPlayers()
        }
    }
    
    private func onAdd() {
        isPresented = true
    }
   
    private var addButton: some View {
       AnyView(Button(action: onAdd) {Image(systemName: "plus")})
        }
    
    var body: some View {
        List{
            ForEach(playerListVM.players, id: \.id){ player in
                
                NavigationLink(value: player, label: {
                    PlayerListRowItem(needsRefresh: $needsRefresh,player: player)
                })
                
            }
            .onDelete(perform: deletePlayer)
        }
            .navigationDestination(for: PlayerViewModel.self) {player in
                PlayerDetailScreen(needsRefresh: $needsRefresh, player: player)
            }
            
            
            
            
//            .onDelete(perform: deletePlayer)
           
            
        
            
        
        
        .listStyle(PlainListStyle())
        // .navigationTitle("Players")
        
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton
            }
            
            
            
        }
        
        
        
        .sheet(isPresented: $isPresented, onDismiss: {
            playerListVM.getAllPlayers()
        }, content: {
            AddPlayerScreen()
        })
        //        .embedInNavigationView()
        
        .onAppear(perform: {
            playerListVM.getAllPlayers()
            
        })
    
    }
}

struct PlayerListScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListScreen()
    }
}

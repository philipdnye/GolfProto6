//
//  GameListScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import SwiftUI

struct GameListScreen: View {
    
    @StateObject private var gameListVM = GameListViewModel()
    @State private var isPresented: Bool = false
    @State private var needsRefresh: Bool = false
    @StateObject private var playerListVM = PlayerListViewModel()
   
    private func deleteGame(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let game = gameListVM.games[index]
            // delete the club
            gameListVM.deleteGame(game: game)
            // get all clubs
            gameListVM.getAllGames()
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
            ForEach(gameListVM.games, id: \.self){game in
                NavigationLink(value: game, label: {
                    GameListRowItem(needsRefresh: $needsRefresh, game: game)
                })
            }
            //on dleete here
            .onDelete(perform: deleteGame)
        }
        
        .navigationDestination(for: GameViewModel.self){game in
            
            GameDetailScreen(game: game)
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton
            }
            
            
            
        }
        //            .navigationTitle("Games")
        //            .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPresented, onDismiss: {
            
            gameListVM.getAllGames()
        }, content: {
           AddGameScreen()
        })
        
        .onAppear(perform: {
            gameListVM.getAllGames()
            
        })
    
    }
}

struct GameListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            GameListScreen()
        }
    }
}

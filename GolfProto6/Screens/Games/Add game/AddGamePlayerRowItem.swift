//
//  AddGamePlayerRowItem.swift
//  GolfProto03
//
//  Created by Philip Nye on 15/04/2023.
//

import SwiftUI

struct AddGamePlayerRowItem: View {
    
    var player = PlayerViewModel(player: Player())
    var body: some View {
        HStack{
            Text(player.firstName)
            Text(player.lastName)
            Text(player.player.handicapArray.currentHandicapIndex().formatted())
//            Text(player.selectedForGame.description)
            
        }
    }
}

struct AddGamePlayerRowItem_Previews: PreviewProvider {
    static var previews: some View {
        let player = PlayerViewModel(player: Player(context: CoreDataManager.shared.viewContext))
        AddGamePlayerRowItem(player: player)
    }
}
